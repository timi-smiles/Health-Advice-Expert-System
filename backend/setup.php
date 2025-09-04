<?php
/**
 * Database Setup Script
 * Run this script to initialize the database and tables
 */

require_once 'config/database.php';

echo "Health Advice Expert System - Database Setup\n";
echo "==========================================\n\n";

try {
    $database = new Database();
    
    // Create database
    echo "Creating database...\n";
    if ($database->createDatabase()) {
        echo "✓ Database created successfully\n";
    } else {
        echo "✗ Failed to create database\n";
        exit(1);
    }
    
    // Get connection
    $conn = $database->getConnection();
    if (!$conn) {
        echo "✗ Failed to connect to database\n";
        exit(1);
    }
    
    echo "✓ Connected to database\n";
    
    // Read and execute schema
    echo "Setting up database schema...\n";
    $schemaFile = dirname(__DIR__) . '/database/schema.sql';
    
    if (!file_exists($schemaFile)) {
        echo "✗ Schema file not found: $schemaFile\n";
        exit(1);
    }
    
    $schema = file_get_contents($schemaFile);
    
    // Split queries by semicolon and execute each one
    $queries = array_filter(array_map('trim', explode(';', $schema)));
    
    foreach ($queries as $query) {
        if (!empty($query) && !preg_match('/^--/', $query)) {
            try {
                $conn->exec($query);
            } catch (PDOException $e) {
                // Ignore "already exists" errors
                if (strpos($e->getMessage(), 'already exists') === false) {
                    echo "Warning: " . $e->getMessage() . "\n";
                }
            }
        }
    }
    
    echo "✓ Database schema setup complete\n";
    
    // Verify tables exist
    echo "Verifying database setup...\n";
    $tables = ['symptoms', 'advice', 'symptom_advice', 'user_sessions'];
    
    foreach ($tables as $table) {
        $stmt = $conn->prepare("SHOW TABLES LIKE ?");
        $stmt->execute([$table]);
        
        if ($stmt->rowCount() > 0) {
            echo "✓ Table '$table' exists\n";
        } else {
            echo "✗ Table '$table' missing\n";
        }
    }
    
    // Check sample data
    echo "Checking sample data...\n";
    $stmt = $conn->query("SELECT COUNT(*) as count FROM symptoms");
    $symptomCount = $stmt->fetch()['count'];
    
    $stmt = $conn->query("SELECT COUNT(*) as count FROM advice");
    $adviceCount = $stmt->fetch()['count'];
    
    echo "✓ Found $symptomCount symptoms and $adviceCount advice entries\n";
    
    echo "\n==========================================\n";
    echo "Database setup completed successfully!\n";
    echo "You can now use the Health Advice Expert System.\n";
    echo "==========================================\n";
    
} catch (Exception $e) {
    echo "✗ Setup failed: " . $e->getMessage() . "\n";
    exit(1);
}
