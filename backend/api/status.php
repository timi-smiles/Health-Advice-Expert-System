<?php
/**
 * System Status API Endpoint
 * Check if the system is properly configured and working
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config/database.php';
require_once '../models/ExpertSystem.php';

try {
    $status = [
        'system' => 'Health Advice Expert System',
        'version' => '1.0.0',
        'timestamp' => date('Y-m-d H:i:s'),
        'status' => 'OK'
    ];

    // Test database connection
    $database = new Database();
    $conn = $database->getConnection();
    
    if ($conn) {
        $status['database'] = 'Connected';
        
        // Test expert system
        $expertSystem = new ExpertSystem();
        
        // Count symptoms and advice
        $stmt = $conn->query("SELECT COUNT(*) as count FROM symptoms");
        $symptomCount = $stmt->fetch()['count'];
        
        $stmt = $conn->query("SELECT COUNT(*) as count FROM advice");
        $adviceCount = $stmt->fetch()['count'];
        
        $status['data'] = [
            'symptoms' => intval($symptomCount),
            'advice_entries' => intval($adviceCount)
        ];
        
        if ($symptomCount > 0 && $adviceCount > 0) {
            $status['ready'] = true;
        } else {
            $status['ready'] = false;
            $status['message'] = 'Database is empty. Run setup.php to initialize.';
        }
        
    } else {
        $status['database'] = 'Failed';
        $status['ready'] = false;
        $status['message'] = 'Database connection failed';
    }

    // Test PHP configuration
    $status['php'] = [
        'version' => PHP_VERSION,
        'pdo_mysql' => extension_loaded('pdo_mysql'),
        'json' => extension_loaded('json')
    ];

    http_response_code(200);
    echo json_encode($status, JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'system' => 'Health Advice Expert System',
        'status' => 'ERROR',
        'message' => 'System error occurred',
        'timestamp' => date('Y-m-d H:i:s')
    ], JSON_PRETTY_PRINT);
}
