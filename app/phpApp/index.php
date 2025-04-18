<?php
// Include database configuration and models
require_once 'config/config.php';
require_once 'models/TestContent.php';

// Include header
include_once 'includes/header.php';

// Fetch some data to display on the dashboard
$testContents = TestContent::getAll();
$totalRecords = count($testContents);

// Check if setup.sql was executed
global $databaseInitialized;
?>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <h1 class="hero-title">Welcome to the LEMP System</h1>
            <p class="hero-subtitle">A content management application developed with the LEMP stack using Docker.</p>
            <a href="views/create.php" class="btn btn-primary">Create Content</a>
        </div>
    </div>
</section>

<!-- Main Content -->
<main class="main">
    <div class="container">
        <h2 class="section-title dashboard-title">Dashboard</h2>
        
        <?php if (isset($databaseInitialized)): ?>
            <div class="alert alert-<?php echo $databaseInitialized ? 'success' : 'warning'; ?> text-center">
                <i class="fas fa-<?php echo $databaseInitialized ? 'check-circle' : 'exclamation-triangle'; ?>"></i>
                Database <?php echo $databaseInitialized ? 'successfully initialized' : 'could not be automatically initialized'; ?>.
            </div>
        <?php endif; ?>
        
        <div class="cards">
            <div class="card dashboard-card">
                <div class="card-header">
                    <h3 class="card-title">Total Records</h3>
                </div>
                <div class="card-body">
                    <p class="card-text dashboard-stats">There are a total of <?php echo $totalRecords; ?> records in the database.</p>
                </div>
                <div class="card-footer">
                    <a href="views/list.php" class="btn btn-primary">View All</a>
                </div>
            </div>
            
            <div class="card dashboard-card">
                <div class="card-header">
                    <h3 class="card-title">Latest Records</h3>
                </div>
                <div class="card-body">
                    <?php if ($totalRecords > 0): ?>
                        <ul class="dashboard-stats">
                            <?php 
                            $count = 0;
                            foreach (array_reverse($testContents) as $content): 
                                if ($count >= 3) break;
                                $count++;
                            ?>
                                <li><?php echo htmlspecialchars($content->getMensaje()); ?></li>
                            <?php endforeach; ?>
                        </ul>
                    <?php else: ?>
                        <p class="dashboard-stats">No records to display.</p>
                    <?php endif; ?>
                </div>
                <div class="card-footer">
                    <a href="views/create.php" class="btn btn-primary">Create New</a>
                </div>
            </div>
            
            <div class="card dashboard-card">
                <div class="card-header">
                    <h3 class="card-title">LEMP Stack</h3>
                </div>
                <div class="card-body">
                    <p class="card-text dashboard-stats">This application is built using:</p>
                    <ul class="dashboard-stats">
                        <li><strong>L</strong>inux</li>
                        <li><strong>E</strong>nginx</li>
                        <li><strong>M</strong>ariaDB</li>
                        <li><strong>P</strong>HP</li>
                    </ul>
                </div>
                <div class="card-footer">
                    <a href="https://github.com/lfelipe1501/LEMPDocker" class="btn btn-primary" target="_blank">View Repository</a>
                </div>
            </div>
        </div>
        
        <div class="section-info" style="margin-top: 2rem;">
            <h3 class="dashboard-title">System Information</h3>
            <div class="table-container">
                <table class="table">
                    <tbody>
                        <tr>
                            <th>PHP Version</th>
                            <td><?php echo phpversion(); ?></td>
                        </tr>
                        <tr>
                            <th>Host</th>
                            <td><?php echo $_SERVER['HTTP_HOST']; ?></td>
                        </tr>
                        <tr>
                            <th>Server Software</th>
                            <td><?php echo $_SERVER['SERVER_SOFTWARE']; ?></td>
                        </tr>
                        <tr>
                            <th>Database</th>
                            <td>MariaDB</td>
                        </tr>
                        <tr>
                            <th>SQL Script</th>
                            <td><?php echo $databaseInitialized ? '<span class="text-success">Executed</span>' : '<span class="text-warning">Not executed</span>'; ?></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<?php include_once 'includes/footer.php'; ?>
