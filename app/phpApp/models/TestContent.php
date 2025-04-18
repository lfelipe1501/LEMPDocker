<?php
require_once __DIR__ . '/../config/config.php';

class TestContent {
    // Properties
    private $id;
    private $mensaje;
    private $nulo;
    
    // Constructor
    public function __construct($id = null, $mensaje = null, $nulo = null) {
        $this->id = $id;
        $this->mensaje = $mensaje;
        $this->nulo = $nulo;
    }
    
    // Getters and Setters
    public function getId() {
        return $this->id;
    }
    
    public function getMensaje() {
        return $this->mensaje;
    }
    
    public function getNulo() {
        return $this->nulo;
    }
    
    public function setMensaje($mensaje) {
        $this->mensaje = $mensaje;
    }
    
    public function setNulo($nulo) {
        $this->nulo = $nulo;
    }
    
    // Database operations
    
    /**
     * Get all records from test_content table
     * 
     * @return array Array of TestContent objects
     */
    public static function getAll() {
        $sql = "SELECT id, mensaje, nulo FROM test_content";
        $data = fetchData($sql);
        
        $testContents = [];
        foreach ($data as $row) {
            $testContents[] = new TestContent($row['id'], $row['mensaje'], $row['nulo']);
        }
        
        return $testContents;
    }
    
    /**
     * Get a record by ID
     * 
     * @param int $id The record ID
     * @return TestContent|null The TestContent object or null if not found
     */
    public static function getById($id) {
        $sql = "SELECT id, mensaje, nulo FROM test_content WHERE id = " . intval($id);
        $data = fetchData($sql);
        
        if (count($data) > 0) {
            return new TestContent($data[0]['id'], $data[0]['mensaje'], $data[0]['nulo']);
        }
        
        return null;
    }
    
    /**
     * Save a new record or update an existing one
     * 
     * @return bool Whether the operation was successful
     */
    public function save() {
        if ($this->id) {
            // Update existing record
            $sql = "UPDATE test_content SET 
                    mensaje = '" . $this->escapeString($this->mensaje) . "', 
                    nulo = " . ($this->nulo === null ? "NULL" : "'" . $this->escapeString($this->nulo) . "'") . " 
                    WHERE id = " . intval($this->id);
        } else {
            // Insert new record
            $sql = "INSERT INTO test_content (mensaje, nulo) VALUES (
                    '" . $this->escapeString($this->mensaje) . "', 
                    " . ($this->nulo === null ? "NULL" : "'" . $this->escapeString($this->nulo) . "'") . ")";
        }
        
        $result = executeQuery($sql);
        
        if (!$this->id && $result) {
            // Get the ID of the newly inserted record
            $conn = getDbConnection();
            $this->id = $conn->insert_id;
            $conn->close();
        }
        
        return $result;
    }
    
    /**
     * Delete a record by ID
     * 
     * @param int $id The record ID
     * @return bool Whether the operation was successful
     */
    public static function delete($id) {
        $sql = "DELETE FROM test_content WHERE id = " . intval($id);
        return executeQuery($sql);
    }
    
    /**
     * Escape a string to prevent SQL injection
     * 
     * @param string $string The string to escape
     * @return string The escaped string
     */
    private function escapeString($string) {
        $conn = getDbConnection();
        $escaped = $conn->real_escape_string($string);
        $conn->close();
        return $escaped;
    }
}
?> 