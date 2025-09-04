<?php
/**
 * Health Advice API Endpoint
 * Returns health advice based on selected symptoms
 */

session_start();

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once '../models/ExpertSystem.php';

try {
    $expertSystem = new ExpertSystem();
    
    // Check if connection is available
    if (!$expertSystem->checkConnection()) {
        throw new Exception('Database connection failed');
    }

    $method = $_SERVER['REQUEST_METHOD'];

    switch ($method) {
        case 'POST':
            handleAdviceRequest($expertSystem);
            break;
        default:
            http_response_code(405);
            echo json_encode([
                'success' => false,
                'message' => 'Method not allowed. Use POST to get advice.'
            ]);
    }

} catch (Exception $e) {
    error_log("Advice API Error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Internal server error'
    ]);
}

function handleAdviceRequest($expertSystem) {
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => 'Invalid JSON data'
        ]);
        return;
    }
    
    $symptomIds = $input['symptoms'] ?? [];
    
    if (empty($symptomIds)) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => 'No symptoms provided. Please select at least one symptom.'
        ]);
        return;
    }
    
    // Validate symptom IDs
    if (!is_array($symptomIds)) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => 'Symptoms must be provided as an array'
        ]);
        return;
    }
    
    // Filter out non-numeric values
    $symptomIds = array_filter($symptomIds, function($id) {
        return is_numeric($id) && $id > 0;
    });
    
    if (empty($symptomIds)) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => 'Invalid symptom IDs provided'
        ]);
        return;
    }
    
    // Get health advice
    $result = $expertSystem->getHealthAdvice($symptomIds);
    
    if ($result['success']) {
        // Log the session for analytics (optional)
        $adviceIds = array_column($result['advice'], 'id');
        $expertSystem->logUserSession($symptomIds, $adviceIds);
        
        // Add additional metadata
        $result['timestamp'] = date('Y-m-d H:i:s');
        $result['session_id'] = session_id() ?: uniqid();
        
        http_response_code(200);
        echo json_encode($result);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
}
