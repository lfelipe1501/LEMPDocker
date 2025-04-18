<?php
// Include database configuration and models
require_once '../config/config.php';
require_once '../models/TestContent.php';

// Include header
include_once '../includes/header.php';

// Check if setup.sql was executed
global $databaseInitialized;

// Get the content of the SQL script
$setupFile = __DIR__ . '/../config/setup.sql';
$sqlContent = '';

if (file_exists($setupFile)) {
    $sqlContent = file_get_contents($setupFile);
}

// Handle manual execution of the SQL script
$manualExecutionResult = null;
if (isset($_POST['execute_sql']) && $_POST['execute_sql'] === '1') {
    $manualExecutionResult = initializeDatabase();
    
    // Redirect to avoid form resubmission
    header('Location: setup.php?executed=1&success=' . ($manualExecutionResult ? '1' : '0'));
    exit;
}

// Check if manually executed
$manuallyExecuted = isset($_GET['executed']) && $_GET['executed'] === '1';
$executionSuccess = isset($_GET['success']) && $_GET['success'] === '1';

// Check if the table exists
$tableExists = false;
try {
    $conn = getDbConnection();
    $result = $conn->query("SHOW TABLES LIKE 'test_content'");
    $tableExists = $result && $result->num_rows > 0;
    $conn->close();
} catch (Exception $e) {
    // Handle error
}

// Get the number of records in the table
$recordCount = 0;
if ($tableExists) {
    $testContents = TestContent::getAll();
    $recordCount = count($testContents);
}
?>

<!-- Main Content -->
<main class="main">
    <div class="container">
        <h2 class="section-title">Database Configuration</h2>
        
        <?php if ($manuallyExecuted): ?>
            <div class="alert alert-<?php echo $executionSuccess ? 'success' : 'danger'; ?> text-center">
                <i class="fas fa-<?php echo $executionSuccess ? 'check-circle' : 'times-circle'; ?>"></i>
                <?php echo $executionSuccess ? 'SQL script executed successfully' : 'Error executing SQL script'; ?>
            </div>
        <?php endif; ?>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Database Status</h3>
            </div>
            <div class="card-body">
                <div class="table-container">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th width="30%">Automatic Initialization</th>
                                <td>
                                    <?php if (isset($databaseInitialized)): ?>
                                        <?php if ($databaseInitialized): ?>
                                            <span class="text-success"><i class="fas fa-check-circle"></i> Completed</span>
                                        <?php else: ?>
                                            <span class="text-warning"><i class="fas fa-exclamation-triangle"></i> Not completed</span>
                                        <?php endif; ?>
                                    <?php else: ?>
                                        <span class="text-secondary">Not determined</span>
                                    <?php endif; ?>
                                </td>
                            </tr>
                            <tr>
                                <th>test_content Table</th>
                                <td>
                                    <?php if ($tableExists): ?>
                                        <span class="text-success"><i class="fas fa-check-circle"></i> Exists</span>
                                    <?php else: ?>
                                        <span class="text-danger"><i class="fas fa-times-circle"></i> Does not exist</span>
                                    <?php endif; ?>
                                </td>
                            </tr>
                            <tr>
                                <th>Records in table</th>
                                <td><?php echo $recordCount; ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <form action="setup.php" method="post" class="mt-4">
                    <input type="hidden" name="execute_sql" value="1">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-database"></i> Execute SQL Script Manually
                    </button>
                    <a href="../index.php" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Home
                    </a>
                </form>
            </div>
        </div>
        
        <div class="card mt-4">
            <div class="card-header">
                <h3 class="card-title">SQL Script Content</h3>
            </div>
            <div class="card-body">
                <pre class="sql-code"><?php echo htmlspecialchars($sqlContent); ?></pre>
            </div>
        </div>
    </div>
</main>

<style>
.mt-4 {
    margin-top: 1.5rem;
}

.sql-code {
    background-color: #f8f9fa;
    color: #212529;
    padding: 15px;
    border-radius: 5px;
    overflow-x: auto;
    font-family: monospace;
    font-size: 0.9rem;
    line-height: 1.5;
    border: 1px solid #dee2e6;
}

/* Dark mode styles for SQL code */
.dark-mode .sql-code {
    background-color: #1e2432;
    color: #e9ecef;
    border-color: #343a40;
}

/* Syntax highlighting for SQL in dark mode */
.dark-mode .sql-code .comment,
.dark-mode .sql-code .sql-comment {
    color: #6c757d;
}

.dark-mode .sql-code .keyword,
.dark-mode .sql-code .sql-keyword {
    color: #6ab1ff;
}

.dark-mode .sql-code .string,
.dark-mode .sql-code .sql-string {
    color: #68cf7b;
}

.dark-mode .sql-code .number,
.dark-mode .sql-code .sql-number {
    color: #f1935c;
}
</style>

<?php include_once '../includes/footer.php'; ?> 