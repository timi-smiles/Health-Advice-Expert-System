<?php
/**
 * Database Configuration for Health Advice Expert System
 */

class Database {
    private $host = 'localhost';
    private $db_name = 'health_expert_system';
    private $username = 'root'; // Change this to your MySQL username
    private $password = '';     // Change this to your MySQL password
    private $conn;

    public function getConnection() {
        $this->conn = null;

        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name,
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch(PDOException $exception) {
            error_log("Connection error: " . $exception->getMessage());
            return null;
        }

        return $this->conn;
    }

    public function createDatabase() {
        try {
            // Connect without specifying database first
            $conn = new PDO(
                "mysql:host=" . $this->host,
                $this->username,
                $this->password
            );
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Create database if it doesn't exist
            $sql = "CREATE DATABASE IF NOT EXISTS " . $this->db_name . " CHARACTER SET utf8 COLLATE utf8_general_ci";
            $conn->exec($sql);

            return true;
        } catch(PDOException $exception) {
            error_log("Database creation error: " . $exception->getMessage());
            return false;
        }
    }

    public function initializeTables() {
        $conn = $this->getConnection();
        if (!$conn) {
            return false;
        }

        try {
            // Create symptoms table
            $sql = "CREATE TABLE IF NOT EXISTS symptoms (
                id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(100) NOT NULL UNIQUE,
                category VARCHAR(50) NOT NULL,
                description TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )";
            $conn->exec($sql);

            // Create advice table
            $sql = "CREATE TABLE IF NOT EXISTS advice (
                id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(200) NOT NULL,
                description TEXT NOT NULL,
                severity ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'MEDIUM',
                category VARCHAR(50),
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )";
            $conn->exec($sql);

            // Create symptom_advice_mapping table for many-to-many relationship
            $sql = "CREATE TABLE IF NOT EXISTS symptom_advice_mapping (
                id INT AUTO_INCREMENT PRIMARY KEY,
                symptom_id INT NOT NULL,
                advice_id INT NOT NULL,
                relevance_score DECIMAL(3,2) DEFAULT 1.00,
                FOREIGN KEY (symptom_id) REFERENCES symptoms(id) ON DELETE CASCADE,
                FOREIGN KEY (advice_id) REFERENCES advice(id) ON DELETE CASCADE,
                UNIQUE KEY unique_mapping (symptom_id, advice_id)
            )";
            $conn->exec($sql);

            // Create user_sessions table to track usage (optional)
            $sql = "CREATE TABLE IF NOT EXISTS user_sessions (
                id INT AUTO_INCREMENT PRIMARY KEY,
                session_id VARCHAR(100) NOT NULL,
                symptoms_searched TEXT,
                advice_given TEXT,
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )";
            $conn->exec($sql);

            return true;
        } catch(PDOException $exception) {
            error_log("Table creation error: " . $exception->getMessage());
            return false;
        }
    }

    public function insertSampleData() {
        $conn = $this->getConnection();
        if (!$conn) {
            return false;
        }

        try {
            // Insert sample symptoms
            $symptoms = [
                ['Headache', 'neurological', 'Pain or discomfort in the head or neck area'],
                ['Fever', 'general', 'Elevated body temperature above normal range'],
                ['Cough', 'respiratory', 'Sudden expulsion of air from the lungs'],
                ['Sore throat', 'respiratory', 'Pain or irritation in the throat'],
                ['Runny nose', 'respiratory', 'Excess nasal drainage'],
                ['Fatigue', 'general', 'Feeling of tiredness or lack of energy'],
                ['Nausea', 'digestive', 'Feeling of queasiness or urge to vomit'],
                ['Vomiting', 'digestive', 'Forceful expulsion of stomach contents'],
                ['Diarrhea', 'digestive', 'Loose or watery bowel movements'],
                ['Stomach pain', 'digestive', 'Pain or discomfort in the abdominal area'],
                ['Back pain', 'musculoskeletal', 'Pain in the back or spine area'],
                ['Joint pain', 'musculoskeletal', 'Pain in the joints'],
                ['Muscle aches', 'musculoskeletal', 'General muscle pain or soreness'],
                ['Dizziness', 'neurological', 'Feeling lightheaded or unsteady'],
                ['Chest pain', 'cardiac', 'Pain or discomfort in the chest area'],
                ['Shortness of breath', 'respiratory', 'Difficulty breathing or breathlessness'],
                ['Skin rash', 'dermatological', 'Changes in skin color, texture, or appearance'],
                ['Itching', 'dermatological', 'Irritating sensation that causes desire to scratch'],
                ['Constipation', 'digestive', 'Difficulty passing stool or infrequent bowel movements'],
                ['Insomnia', 'neurological', 'Difficulty falling asleep or staying asleep']
            ];

            $stmt = $conn->prepare("INSERT IGNORE INTO symptoms (name, category, description) VALUES (?, ?, ?)");
            foreach ($symptoms as $symptom) {
                $stmt->execute($symptom);
            }

            // Insert sample advice
            $advice = [
                ['Rest and Hydration', 'Get plenty of rest and drink fluids. Monitor symptoms and seek medical attention if they worsen.', 'LOW', 'general'],
                ['Over-the-Counter Pain Relief', 'Consider taking acetaminophen or ibuprofen as directed. Do not exceed recommended dosage.', 'LOW', 'general'],
                ['Seek Medical Attention', 'Consult with a healthcare professional for proper diagnosis and treatment.', 'MEDIUM', 'general'],
                ['Emergency Care Required', 'Seek immediate emergency medical care. Call emergency services if symptoms are severe.', 'HIGH', 'emergency'],
                ['Cold and Flu Care', 'Rest, fluids, and over-the-counter medications may help. Symptoms typically resolve in 7-10 days.', 'LOW', 'respiratory'],
                ['Digestive Rest', 'Eat bland foods, stay hydrated, and rest your digestive system. Avoid dairy and fatty foods.', 'LOW', 'digestive'],
                ['Heat and Cold Therapy', 'Apply heat or cold to affected areas as appropriate. Gentle stretching may help with muscle pain.', 'LOW', 'musculoskeletal'],
                ['Monitor Heart Symptoms', 'Chest pain requires immediate medical evaluation. Do not ignore cardiac symptoms.', 'HIGH', 'cardiac'],
                ['Skin Care', 'Keep affected area clean and dry. Avoid scratching. Use gentle, fragrance-free products.', 'LOW', 'dermatological'],
                ['Sleep Hygiene', 'Maintain regular sleep schedule, avoid caffeine late in day, and create comfortable sleep environment.', 'MEDIUM', 'neurological']
            ];

            $stmt = $conn->prepare("INSERT IGNORE INTO advice (title, description, severity, category) VALUES (?, ?, ?, ?)");
            foreach ($advice as $adv) {
                $stmt->execute($adv);
            }

            // Create symptom-advice mappings
            $mappings = [
                // Headache mappings
                [1, 1, 0.9], [1, 2, 0.8], [1, 3, 0.7],
                // Fever mappings  
                [2, 1, 0.9], [2, 3, 0.8], [2, 5, 0.7],
                // Cough mappings
                [3, 1, 0.8], [3, 5, 0.9], [3, 3, 0.6],
                // Respiratory symptoms
                [4, 5, 0.9], [4, 1, 0.7], [5, 5, 0.8],
                // Digestive symptoms
                [7, 6, 0.9], [8, 6, 0.9], [9, 6, 0.9], [10, 6, 0.8],
                // Musculoskeletal symptoms
                [11, 7, 0.9], [12, 7, 0.8], [13, 7, 0.8],
                // Cardiac symptoms
                [15, 8, 1.0], [15, 4, 0.9],
                // Respiratory distress
                [16, 4, 0.9], [16, 8, 0.8],
                // Dermatological symptoms
                [17, 9, 0.9], [18, 9, 0.8],
                // Sleep issues
                [20, 10, 0.9]
            ];

            $stmt = $conn->prepare("INSERT IGNORE INTO symptom_advice_mapping (symptom_id, advice_id, relevance_score) VALUES (?, ?, ?)");
            foreach ($mappings as $mapping) {
                $stmt->execute($mapping);
            }

            return true;
        } catch(PDOException $exception) {
            error_log("Sample data insertion error: " . $exception->getMessage());
            return false;
        }
    }
}
?>
