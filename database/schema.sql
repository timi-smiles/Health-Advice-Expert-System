-- Health Advice Expert System Database Schema
-- Run this script to create the necessary tables

-- Create the database (if not already created)
CREATE DATABASE IF NOT EXISTS health_expert_system CHARACTER SET utf8 COLLATE utf8_general_ci;
USE health_expert_system;

-- Table for storing symptoms
CREATE TABLE IF NOT EXISTS symptoms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    severity_level ENUM('low', 'medium', 'high', 'emergency') DEFAULT 'medium',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_name (name)
);

-- Table for storing health advice/recommendations
CREATE TABLE IF NOT EXISTS advice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    recommendation TEXT NOT NULL,
    severity_level ENUM('low', 'medium', 'high', 'emergency') DEFAULT 'medium',
    category VARCHAR(100),
    when_to_see_doctor TEXT,
    emergency_signs TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_severity (severity_level)
);

-- Junction table for symptom-advice relationships (many-to-many)
CREATE TABLE IF NOT EXISTS symptom_advice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    symptom_id INT NOT NULL,
    advice_id INT NOT NULL,
    weight DECIMAL(3,2) DEFAULT 1.00, -- Relevance weight (0.00 to 1.00)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (symptom_id) REFERENCES symptoms(id) ON DELETE CASCADE,
    FOREIGN KEY (advice_id) REFERENCES advice(id) ON DELETE CASCADE,
    UNIQUE KEY unique_symptom_advice (symptom_id, advice_id),
    INDEX idx_symptom (symptom_id),
    INDEX idx_advice (advice_id)
);

-- Table for user sessions (optional - for tracking)
CREATE TABLE IF NOT EXISTS user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    symptoms_submitted TEXT, -- JSON array of symptom IDs
    advice_given TEXT, -- JSON array of advice IDs
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_session (session_id),
    INDEX idx_created (created_at)
);

-- Insert sample symptoms
INSERT INTO symptoms (name, category, severity_level, description) VALUES
('Headache', 'neurological', 'medium', 'Pain or discomfort in the head or upper neck'),
('Fever', 'general', 'medium', 'Elevated body temperature above normal range'),
('Cough', 'respiratory', 'medium', 'Sudden expulsion of air from the lungs'),
('Sore throat', 'respiratory', 'low', 'Pain or irritation in the throat'),
('Runny nose', 'respiratory', 'low', 'Excess drainage from the nose'),
('Fatigue', 'general', 'medium', 'Extreme tiredness or lack of energy'),
('Nausea', 'digestive', 'medium', 'Feeling of sickness with urge to vomit'),
('Vomiting', 'digestive', 'medium', 'Forceful expulsion of stomach contents'),
('Diarrhea', 'digestive', 'medium', 'Loose or watery bowel movements'),
('Stomach pain', 'digestive', 'medium', 'Pain or discomfort in the abdominal area'),
('Back pain', 'musculoskeletal', 'medium', 'Pain in the back muscles or spine'),
('Joint pain', 'musculoskeletal', 'medium', 'Pain in one or more joints'),
('Muscle aches', 'musculoskeletal', 'low', 'General muscle pain or soreness'),
('Dizziness', 'neurological', 'medium', 'Feeling of unsteadiness or lightheadedness'),
('Chest pain', 'cardiac', 'high', 'Pain or discomfort in the chest area'),
('Shortness of breath', 'respiratory', 'high', 'Difficulty breathing or feeling breathless'),
('Skin rash', 'dermatological', 'low', 'Changes in skin color, texture, or appearance'),
('Itching', 'dermatological', 'low', 'Uncomfortable sensation causing desire to scratch'),
('Constipation', 'digestive', 'low', 'Difficulty or infrequent bowel movements'),
('Insomnia', 'neurological', 'medium', 'Difficulty falling or staying asleep');

-- Insert sample advice
INSERT INTO advice (title, description, recommendation, severity_level, category, when_to_see_doctor, emergency_signs) VALUES
('Common Cold Management', 'Symptoms suggest a common cold or upper respiratory infection', 'Rest, stay hydrated, use warm salt water gargles, consider over-the-counter pain relievers. Symptoms usually resolve in 7-10 days.', 'low', 'respiratory', 'See a doctor if symptoms worsen after 10 days, fever exceeds 101.3°F (38.5°C), or you develop ear pain.', 'Difficulty breathing, high fever, severe headache'),

('Tension Headache Relief', 'Common tension-type headache management', 'Apply cold or warm compress, rest in quiet dark room, stay hydrated, consider over-the-counter pain relievers. Practice stress management techniques.', 'medium', 'neurological', 'See a doctor for severe headaches, sudden onset headaches, or headaches with vision changes.', 'Sudden severe headache, headache with fever and stiff neck, vision changes'),

('Gastrointestinal Upset', 'Digestive system irritation or mild food poisoning', 'Stay hydrated with clear fluids, eat bland foods (BRAT diet), rest, avoid dairy and fatty foods. Gradually return to normal diet.', 'medium', 'digestive', 'See a doctor if symptoms persist over 48 hours, signs of dehydration, or severe abdominal pain.', 'Severe dehydration, blood in vomit or stool, severe abdominal pain'),

('Muscle Strain Recovery', 'Overuse or minor injury to muscles', 'Rest the affected area, apply ice for first 48 hours, then heat, gentle stretching, over-the-counter anti-inflammatory medications.', 'low', 'musculoskeletal', 'See a doctor if pain is severe, persists over a week, or limits mobility significantly.', 'Severe pain, numbness, inability to move affected area'),

('Chest Pain Evaluation', 'Chest discomfort requiring immediate attention', 'SEEK IMMEDIATE MEDICAL ATTENTION. Do not ignore chest pain. Call emergency services if severe.', 'emergency', 'cardiac', 'IMMEDIATE medical attention required for any chest pain.', 'All chest pain should be evaluated immediately'),

('Respiratory Difficulty', 'Breathing problems requiring urgent care', 'SEEK IMMEDIATE MEDICAL ATTENTION. Sit upright, loosen tight clothing, use prescribed inhaler if available.', 'emergency', 'respiratory', 'IMMEDIATE medical attention required for breathing difficulties.', 'Severe shortness of breath, blue lips or face, inability to speak'),

('Skin Irritation Care', 'Minor skin conditions and allergic reactions', 'Keep area clean and dry, avoid irritants, apply cool compress, use gentle moisturizers, avoid scratching.', 'low', 'dermatological', 'See a doctor if rash spreads rapidly, develops blisters, or is accompanied by fever.', 'Widespread rash with fever, difficulty breathing, severe swelling'),

('Sleep Hygiene Improvement', 'Difficulty sleeping and insomnia management', 'Maintain regular sleep schedule, create comfortable sleep environment, avoid caffeine late in day, establish bedtime routine, limit screen time before bed.', 'medium', 'neurological', 'See a doctor if insomnia persists over 2 weeks or significantly impacts daily life.', 'Severe mood changes, hallucinations, extreme fatigue affecting safety');

-- Link symptoms to advice (many-to-many relationships)
INSERT INTO symptom_advice (symptom_id, advice_id, weight) VALUES
-- Common Cold (advice_id = 1)
(3, 1, 1.00), -- Cough
(4, 1, 1.00), -- Sore throat
(5, 1, 1.00), -- Runny nose
(2, 1, 0.80), -- Fever
(6, 1, 0.60), -- Fatigue

-- Tension Headache (advice_id = 2)
(1, 2, 1.00), -- Headache
(6, 2, 0.70), -- Fatigue
(20, 2, 0.50), -- Insomnia

-- GI Upset (advice_id = 3)
(7, 3, 1.00), -- Nausea
(8, 3, 1.00), -- Vomiting
(9, 3, 1.00), -- Diarrhea
(10, 3, 1.00), -- Stomach pain
(2, 3, 0.60), -- Fever
(6, 3, 0.50), -- Fatigue

-- Muscle Strain (advice_id = 4)
(11, 4, 1.00), -- Back pain
(12, 4, 1.00), -- Joint pain
(13, 4, 1.00), -- Muscle aches

-- Chest Pain Emergency (advice_id = 5)
(15, 5, 1.00), -- Chest pain

-- Respiratory Emergency (advice_id = 6)
(16, 6, 1.00), -- Shortness of breath
(15, 6, 0.80), -- Chest pain (can be related)

-- Skin Care (advice_id = 7)
(17, 7, 1.00), -- Skin rash
(18, 7, 1.00), -- Itching

-- Sleep Issues (advice_id = 8)
(20, 8, 1.00), -- Insomnia
(6, 8, 0.60), -- Fatigue
(1, 8, 0.40); -- Headache
