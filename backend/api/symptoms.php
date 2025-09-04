<?php
/**
 * Symptoms API Endpoint
 * Returns list of symptoms for autocomplete and selection
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
        case 'GET':
            handleGetRequest($expertSystem);
            break;
        case 'POST':
            handlePostRequest($expertSystem);
            break;
        default:
            http_response_code(405);
            echo json_encode([
                'success' => false,
                'message' => 'Method not allowed'
            ]);
    }

} catch (Exception $e) {
    error_log("Symptoms API Error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Internal server error'
    ]);
}

function handleGetRequest($expertSystem) {
    $search = $_GET['search'] ?? '';
    
    if (!empty($search)) {
        // Search for symptoms
        $result = $expertSystem->searchSymptoms($search);
    } else {
        // Get all symptoms
        $result = $expertSystem->getAllSymptoms();
    }
    
    if ($result['success']) {
        http_response_code(200);
        echo json_encode($result);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
}

function handlePostRequest($expertSystem) {
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => 'Invalid JSON data'
        ]);
        return;
    }
    
    $action = $input['action'] ?? '';
    
    switch ($action) {
        case 'search':
            $search = $input['search'] ?? '';
            if (empty($search)) {
                http_response_code(400);
                echo json_encode([
                    'success' => false,
                    'message' => 'Search term required'
                ]);
                return;
            }
            
            $result = $expertSystem->searchSymptoms($search);
            break;
            
        default:
            http_response_code(400);
            echo json_encode([
                'success' => false,
                'message' => 'Invalid action'
            ]);
            return;
    }
    
    if ($result['success']) {
        http_response_code(200);
        echo json_encode($result);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
}
