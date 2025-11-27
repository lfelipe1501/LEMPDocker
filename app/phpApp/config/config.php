<?php
// Database configuration
$servername = "mariadb";
$username = getenv('USERDB');
$password = getenv('UPWDB');
$dbname = getenv('DBUP');

// Create connection
function getDbConnection() {
    global $servername, $username, $password, $dbname;
    
    $conn = new mysqli($servername, $username, $password, $dbname);
    
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    return $conn;
}

// Function to fetch data from database
function fetchData($sql) {
    $conn = getDbConnection();
    $result = $conn->query($sql);
    
    $data = [];
    if ($result && $result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
    }
    
    $conn->close();
    return $data;
}

// Function to execute queries
function executeQuery($sql) {
    $conn = getDbConnection();
    $result = $conn->query($sql);
    $conn->close();
    return $result;
}

// Function to execute multiple SQL statements
function executeMultipleQueries($sqlContent) {
    $conn = getDbConnection();
    $success = true;
    
    // Disable autocommit to allow transactions
    $conn->autocommit(false);
    
    try {
        // Execute multiple queries
        if ($conn->multi_query($sqlContent)) {
            do {
                // Store the result of the current result set
                if ($result = $conn->store_result()) {
                    $result->free();
                }
                // Prepare for next query if it exists
            } while ($conn->more_results() && $conn->next_result());
        }
        
        // If there's an error, mark as failed
        if ($conn->error) {
            $success = false;
            error_log("Error executing SQL script: " . $conn->error);
        } else {
            // Commit changes
            $conn->commit();
        }
    } catch (Exception $e) {
        // Rollback in case of error
        $conn->rollback();
        $success = false;
        error_log("Exception executing SQL script: " . $e->getMessage());
    }
    
    // Re-enable autocommit
    $conn->autocommit(true);
    $conn->close();
    
    return $success;
}

// Execute SQL script when application starts
function initializeDatabase() {
    $setupFile = __DIR__ . '/setup.sql';
    
    if (file_exists($setupFile)) {
        $sqlContent = file_get_contents($setupFile);
        if ($sqlContent) {
            return executeMultipleQueries($sqlContent);
        }
    }
    
    return false;
}

// Initialize the database
$databaseInitialized = initializeDatabase();