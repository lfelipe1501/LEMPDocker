<?php
// Include database configuration and models
require_once '../config/config.php';
require_once '../models/TestContent.php';

// Include header
include_once '../includes/header.php';

// Check if ID is provided
if (!isset($_GET['id']) || empty($_GET['id'])) {
    $_SESSION['message'] = 'Invalid ID.';
    $_SESSION['message_type'] = 'danger';
    header('Location: list.php');
    exit;
}

$id = intval($_GET['id']);
$testContent = TestContent::getById($id);

// Check if record exists
if (!$testContent) {
    $_SESSION['message'] = 'Record not found.';
    $_SESSION['message_type'] = 'danger';
    header('Location: list.php');
    exit;
}

// Process form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $mensaje = isset($_POST['mensaje']) ? trim($_POST['mensaje']) : '';
    $nulo = isset($_POST['nulo']) && !empty($_POST['nulo']) ? trim($_POST['nulo']) : null;
    
    // Validate form data
    $errors = [];
    
    if (empty($mensaje)) {
        $errors[] = 'The Message field is required.';
    }
    
    // If no errors, update the record
    if (empty($errors)) {
        $testContent->setMensaje($mensaje);
        $testContent->setNulo($nulo);
        
        if ($testContent->save()) {
            $_SESSION['message'] = 'Record updated successfully.';
            $_SESSION['message_type'] = 'success';
            
            // Redirect to avoid resubmission on refresh
            header('Location: list.php');
            exit;
        } else {
            $errors[] = 'Error updating the record.';
        }
    }
}
?>

<!-- Main Content -->
<main class="main">
    <div class="container">
        <h2 class="section-title">Edit Record</h2>
        
        <?php if (isset($errors) && !empty($errors)): ?>
            <div class="alert alert-danger">
                <ul>
                    <?php foreach ($errors as $error): ?>
                        <li><?php echo $error; ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Edit Content #<?php echo $testContent->getId(); ?></h3>
            </div>
            <div class="card-body">
                <form action="edit.php?id=<?php echo $testContent->getId(); ?>" method="post" class="needs-validation">
                    <div class="form-group">
                        <label for="mensaje" class="form-label">Message *</label>
                        <input type="text" id="mensaje" name="mensaje" class="form-control" value="<?php echo htmlspecialchars($testContent->getMensaje()); ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="nulo" class="form-label">Value (optional)</label>
                        <input type="text" id="nulo" name="nulo" class="form-control" value="<?php echo $testContent->getNulo() !== null ? htmlspecialchars($testContent->getNulo()) : ''; ?>">
                        <small class="text-muted">Leave this field blank to store a NULL value.</small>
                    </div>
                    
                    <div class="form-group" style="margin-top: 1.5rem;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update
                        </button>
                        <a href="list.php" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<?php include_once '../includes/footer.php'; ?> 