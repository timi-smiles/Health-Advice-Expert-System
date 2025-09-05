<?php
/**
 * Expert System Model
 * Handles all database operations for the health advice expert system
 */

require_once '../config/database.php';

class ExpertSystem {
    private $conn;
    private $database;

    public function __construct() {
        $this->database = new Database();
        $this->conn = $this->database->getConnection();
    }

    /**
     * Get all symptoms from the database
     */
    public function getAllSymptoms() {
        try {
            $query = "SELECT id, name, category, severity_level, description 
                     FROM symptoms 
                     ORDER BY category, name";
            
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            
            return [
                'success' => true,
                'symptoms' => $stmt->fetchAll()
            ];
        } catch (Exception $e) {
            error_log("Error fetching symptoms: " . $e->getMessage());
            return [
                'success' => false,
                'message' => 'Failed to fetch symptoms'
            ];
        }
    }

    /**
     * Search symptoms by name
     */
    public function searchSymptoms($searchTerm) {
        try {
            $query = "SELECT id, name, category, severity_level, description 
                     FROM symptoms 
                     WHERE name LIKE :search 
                     ORDER BY 
                        CASE WHEN name LIKE :exact THEN 1 ELSE 2 END,
                        name";
            
            $stmt = $this->conn->prepare($query);
            $searchPattern = '%' . $searchTerm . '%';
            $exactPattern = $searchTerm . '%';
            
            $stmt->bindParam(':search', $searchPattern);
            $stmt->bindParam(':exact', $exactPattern);
            $stmt->execute();
            
            return [
                'success' => true,
                'symptoms' => $stmt->fetchAll()
            ];
        } catch (Exception $e) {
            error_log("Error searching symptoms: " . $e->getMessage());
            return [
                'success' => false,
                'message' => 'Failed to search symptoms'
            ];
        }
    }

    /**
     * Get health advice based on selected symptoms
     */
    public function getHealthAdvice($symptomIds) {
        try {
            if (empty($symptomIds)) {
                return [
                    'success' => false,
                    'message' => 'No symptoms provided'
                ];
            }

            // Convert symptom IDs to array if string
            if (is_string($symptomIds)) {
                $symptomIds = json_decode($symptomIds, true);
            }

            // Validate symptom IDs
            $symptomIds = array_filter($symptomIds, 'is_numeric');
            
            if (empty($symptomIds)) {
                return [
                    'success' => false,
                    'message' => 'Invalid symptom IDs provided'
                ];
            }

            $placeholders = str_repeat('?,', count($symptomIds) - 1) . '?';
            
            // Get advice based on symptoms with weighted scoring
            // Simple but effective filtering
            $symptomCount = count($symptomIds);
            $minRelevanceScore = 1; // Very low threshold to ensure relevant advice shows
            $minMatchingSymptoms = 1; // At least 1 symptom must match
            
            $query = "SELECT 
                        a.id,
                        a.title,
                        a.description,
                        a.recommendation,
                        a.severity_level,
                        a.category,
                        a.when_to_see_doctor,
                        a.emergency_signs,
                        SUM(sa.weight) as relevance_score,
                        COUNT(sa.symptom_id) as matching_symptoms,
                        ROUND((COUNT(sa.symptom_id) * 100.0 / ?), 1) as symptom_match_percentage
                     FROM advice a
                     INNER JOIN symptom_advice sa ON a.id = sa.advice_id
                     WHERE sa.symptom_id IN ($placeholders)
                     GROUP BY a.id, a.severity_level
                     HAVING relevance_score >= ? AND matching_symptoms >= ?
                     ORDER BY 
                        matching_symptoms DESC,
                        relevance_score DESC,
                        CASE a.severity_level 
                            WHEN 'emergency' THEN 4 
                            WHEN 'high' THEN 3 
                            WHEN 'medium' THEN 2 
                            ELSE 1 
                        END DESC
                     LIMIT 2"; // Maximum 2 most relevant advice items

            $stmt = $this->conn->prepare($query);
            
            // Bind parameters with reasonable thresholds
            $params = array_merge(
                [$symptomCount], // For percentage calculation
                $symptomIds,     // For WHERE clause
                [$minRelevanceScore], // Main relevance threshold (much lower)
                [$minMatchingSymptoms] // Minimum matching symptoms
            );
            
            $stmt->execute($params);
            $advice = $stmt->fetchAll();

            // Get symptom details for context
            $symptomQuery = "SELECT id, name, category, severity_level 
                           FROM symptoms 
                           WHERE id IN ($placeholders)";
            $symptomStmt = $this->conn->prepare($symptomQuery);
            $symptomStmt->execute($symptomIds);
            $symptoms = $symptomStmt->fetchAll();

            // Determine overall severity
            $overallSeverity = $this->calculateOverallSeverity($symptoms, $advice);

            return [
                'success' => true,
                'advice' => $advice,
                'symptoms' => $symptoms,
                'overall_severity' => $overallSeverity,
                'emergency_warning' => $overallSeverity === 'emergency' || $overallSeverity === 'high'
            ];

        } catch (Exception $e) {
            error_log("Error getting health advice: " . $e->getMessage());
            return [
                'success' => false,
                'message' => 'Failed to get health advice'
            ];
        }
    }

    /**
     * Calculate overall severity based on symptoms and advice
     */
    private function calculateOverallSeverity($symptoms, $advice) {
        $severityLevels = ['low' => 1, 'medium' => 2, 'high' => 3, 'emergency' => 4];
        $maxSeverity = 1;

        // Check symptom severity
        foreach ($symptoms as $symptom) {
            $level = $severityLevels[$symptom['severity_level']] ?? 1;
            $maxSeverity = max($maxSeverity, $level);
        }

        // Check advice severity
        foreach ($advice as $adviceItem) {
            $level = $severityLevels[$adviceItem['severity_level']] ?? 1;
            $maxSeverity = max($maxSeverity, $level);
        }

        // Convert back to string
        $reverseLevels = array_flip($severityLevels);
        return $reverseLevels[$maxSeverity];
    }

    /**
     * Log user session for analytics (optional)
     */
    public function logUserSession($symptomIds, $adviceIds, $sessionId = null) {
        try {
            $sessionId = $sessionId ?: session_id() ?: uniqid();
            $ipAddress = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
            $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? 'unknown';

            $query = "INSERT INTO user_sessions 
                     (session_id, symptoms_submitted, advice_given, ip_address, user_agent) 
                     VALUES (?, ?, ?, ?, ?)";

            $stmt = $this->conn->prepare($query);
            $stmt->execute([
                $sessionId,
                json_encode($symptomIds),
                json_encode($adviceIds),
                $ipAddress,
                $userAgent
            ]);

            return ['success' => true];
        } catch (Exception $e) {
            error_log("Error logging session: " . $e->getMessage());
            return ['success' => false];
        }
    }

    /**
     * Get symptom categories for filtering
     */
    public function getSymptomCategories() {
        try {
            $query = "SELECT DISTINCT category 
                     FROM symptoms 
                     ORDER BY category";
            
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            
            $categories = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            return [
                'success' => true,
                'categories' => $categories
            ];
        } catch (Exception $e) {
            error_log("Error fetching categories: " . $e->getMessage());
            return [
                'success' => false,
                'message' => 'Failed to fetch categories'
            ];
        }
    }

    /**
     * Check database connection
     */
    public function checkConnection() {
        return $this->conn !== null;
    }
}
