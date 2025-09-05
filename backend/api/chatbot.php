<?php
session_start();
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once '../models/ExpertSystem.php';

try {
    $expertSystem = new ExpertSystem();
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $input = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($input['message'])) {
            echo json_encode([
                'success' => false,
                'message' => 'No message provided'
            ]);
            exit;
        }
        
        $message = strtolower(trim($input['message']));
        
        // Extract symptoms from natural language
        $extractedSymptoms = extractSymptomsFromText($message, $expertSystem);
        
        if (empty($extractedSymptoms)) {
            echo json_encode([
                'success' => true,
                'type' => 'no_symptoms',
                'message' => 'I didn\'t detect any symptoms. Describe what you\'re feeling.',
                'suggestions' => [
                    'I have a headache',
                    'I feel tired and have fever',
                    'I have chest pain',
                    'I have a cough and runny nose'
                ]
            ]);
            exit;
        }
        
        // Get health advice for extracted symptoms
        $symptomIds = array_map(function($symptom) { return $symptom['id']; }, $extractedSymptoms);
        $adviceResult = $expertSystem->getHealthAdvice($symptomIds);
        
        if ($adviceResult['success']) {
            // Format advice for chatbot
            $chatbotResponse = formatAdviceForChatbot($adviceResult, $extractedSymptoms);
            echo json_encode($chatbotResponse);
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Unable to get health advice at this time'
            ]);
        }
        
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Only POST method allowed'
        ]);
    }
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Server error: ' . $e->getMessage()
    ]);
}

function extractSymptomsFromText($text, $expertSystem) {
    $allSymptoms = $expertSystem->getAllSymptoms();
    $foundSymptoms = [];
    
    if (!$allSymptoms['success']) {
        return [];
    }
    
    // Clean and normalize the input text
    $text = strtolower(trim($text));
    $text = preg_replace('/[^a-z0-9\s]/', ' ', $text); // Remove punctuation
    $text = preg_replace('/\s+/', ' ', $text); // Normalize spaces
    
    // First pass: Check for common keywords that should map to symptoms
    $commonMappings = [
        'cold' => 'Common cold symptoms',
        'headache' => 'Headache',
        'heache' => 'Headache', // typo
        'head ache' => 'Headache',
        'head pain' => 'Headache',
        'cough' => 'Persistent cough',
        'cogh' => 'Persistent cough', // typo
        'coughing' => 'Persistent cough',
        'fever' => 'Fever',
        'runny nose' => 'Runny nose',
        'stuffy nose' => 'Nasal congestion',
        'sore throat' => 'Sore throat',
        'fatigue' => 'Fatigue',
        'tired' => 'Fatigue'
    ];
    
    foreach ($commonMappings as $keyword => $symptomName) {
        if (strpos($text, $keyword) !== false) {
            // Find the actual symptom in database
            foreach ($allSymptoms['symptoms'] as $symptom) {
                if (strtolower($symptom['name']) === strtolower($symptomName)) {
                    $foundSymptoms[] = $symptom;
                    break;
                }
            }
        }
    }
    
    // Second pass: Regular symptom matching
    foreach ($allSymptoms['symptoms'] as $symptom) {
        $symptomName = strtolower($symptom['name']);
        
        // Skip if already found
        $alreadyFound = false;
        foreach ($foundSymptoms as $found) {
            if ($found['id'] === $symptom['id']) {
                $alreadyFound = true;
                break;
            }
        }
        if ($alreadyFound) continue;
        
        // Direct match
        if (strpos($text, $symptomName) !== false) {
            $foundSymptoms[] = $symptom;
            continue;
        }
        
        // Common variations and synonyms
        $variations = getSymptomVariations($symptomName);
        foreach ($variations as $variation) {
            if (strpos($text, $variation) !== false) {
                $foundSymptoms[] = $symptom;
                break;
            }
        }
    }
    
    return $foundSymptoms;
}

function getSymptomVariations($symptom) {
    $variations = [
        'headache' => ['head ache', 'head pain', 'migraine', 'head hurts', 'heache', 'headach'],
        'fever' => ['high temperature', 'hot', 'burning up', 'feverish', 'temperature'],
        'cough' => ['coughing', 'hacking', 'dry cough', 'wet cough', 'cof', 'cogh'],
        'fatigue' => ['tired', 'exhausted', 'weak', 'no energy', 'sleepy', 'weakness'],
        'chest pain' => ['chest ache', 'heart pain', 'chest hurts'],
        'sore throat' => ['throat pain', 'throat ache', 'throat hurts'],
        'runny nose' => ['stuffy nose', 'nasal congestion', 'blocked nose', 'cold', 'common cold', 'runny'],
        'nasal congestion' => ['stuffy nose', 'blocked nose', 'cold', 'common cold'],
        'common cold' => ['cold', 'runny nose', 'stuffy nose'],
        'stomach pain' => ['stomach ache', 'belly pain', 'abdominal pain', 'tummy ache'],
        'shortness of breath' => ['hard to breathe', 'cant breathe', 'breathing difficulty'],
        'nausea' => ['feel sick', 'queasy', 'want to vomit'],
        'dizziness' => ['dizzy', 'lightheaded', 'spinning'],
        'muscle pain' => ['muscle ache', 'body ache', 'sore muscles'],
        'sneezing' => ['sneeze', 'sneezing'],
        'body aches' => ['body ache', 'muscle pain', 'aches']
    ];
    
    return $variations[$symptom] ?? [];
}

function formatAdviceForChatbot($adviceResult, $extractedSymptoms) {
    $advice = $adviceResult['advice'];
    $symptoms = $extractedSymptoms;
    
    if (empty($advice)) {
        return [
            'success' => true,
            'type' => 'no_advice',
            'message' => 'I couldn\'t find specific advice for your symptoms. Consider consulting a healthcare professional.',
            'symptoms' => array_map(function($s) { return $s['name']; }, $symptoms)
        ];
    }
    
    $response = [
        'success' => true,
        'type' => 'advice',
        'symptoms' => array_map(function($s) { return $s['name']; }, $symptoms),
        'advice_count' => count($advice),
        'advice_items' => []
    ];
    
    // Format each advice item for chatbot
    foreach ($advice as $item) {
        $formattedAdvice = [
            'title' => $item['title'],
            'recommendation' => shortenText($item['recommendation'], 150),
            'severity' => $item['severity_level'],
            'matches' => $item['matching_symptoms'],
            'match_percentage' => $item['symptom_match_percentage'] ?? 0
        ];
        
        if ($item['when_to_see_doctor']) {
            $formattedAdvice['doctor_advice'] = shortenText($item['when_to_see_doctor'], 100);
        }
        
        $response['advice_items'][] = $formattedAdvice;
    }
    
    return $response;
}

function shortenText($text, $maxLength) {
    if (strlen($text) <= $maxLength) {
        return $text;
    }
    
    $shortened = substr($text, 0, $maxLength);
    $lastSpace = strrpos($shortened, ' ');
    
    if ($lastSpace !== false) {
        $shortened = substr($shortened, 0, $lastSpace);
    }
    
    return $shortened . '...';
}
?>
