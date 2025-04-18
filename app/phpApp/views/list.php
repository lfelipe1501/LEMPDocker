<?php
// Include database configuration and models
require_once '../config/config.php';
require_once '../models/TestContent.php';

// Include header
include_once '../includes/header.php';

// Handle delete action
if (isset($_GET['delete']) && !empty($_GET['delete'])) {
    $id = intval($_GET['delete']);
    
    if (TestContent::delete($id)) {
        $_SESSION['message'] = 'Record deleted successfully.';
        $_SESSION['message_type'] = 'success';
    } else {
        $_SESSION['message'] = 'Error deleting record.';
        $_SESSION['message_type'] = 'danger';
    }
    
    // Redirect to avoid resubmission on refresh
    header('Location: list.php');
    exit;
}

// Fetch all records
$testContents = TestContent::getAll();
?>

<!-- Main Content -->
<main class="main">
    <div class="container">
        <h2 class="section-title">Content Listing</h2>
        
        <div class="actions" style="margin-bottom: 1.5rem; text-align: right;">
            <a href="create.php" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i> New Record
            </a>
        </div>
        
        <div class="table-container">
            <?php if (count($testContents) > 0): ?>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Message</th>
                            <th>Null Value</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($testContents as $content): ?>
                            <tr>
                                <td><?php echo $content->getId(); ?></td>
                                <td><?php echo htmlspecialchars($content->getMensaje()); ?></td>
                                <td><?php echo $content->getNulo() !== null ? htmlspecialchars($content->getNulo()) : '<em>NULL</em>'; ?></td>
                                <td>
                                    <a href="edit.php?id=<?php echo $content->getId(); ?>" class="btn-link" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="javascript:void(0);" onclick="confirmDelete(<?php echo $content->getId(); ?>)" class="btn-link text-danger" title="Delete">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php else: ?>
                <div class="alert alert-info">
                    No records available. <a href="create.php">Create a new one</a>.
                </div>
            <?php endif; ?>
        </div>
    </div>
</main>

<script>
    function confirmDelete(id) {
        if (confirm('Are you sure you want to delete this record? This action cannot be undone.')) {
            window.location.href = 'list.php?delete=' + id;
        }
    }
</script>

<?php include_once '../includes/footer.php'; ?> 