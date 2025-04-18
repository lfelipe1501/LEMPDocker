<?php
// Start a session if not already started
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Function to check if the current page matches a given page
function isActivePage($page) {
    $currentPage = basename($_SERVER['PHP_SELF']);
    return ($currentPage === $page) ? 'active' : '';
}

// Calculate base URL based on current script path
$basePath = '';
if (strpos($_SERVER['PHP_SELF'], '/views/') !== false) {
    $basePath = '../';
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="color-scheme" content="light dark">
    <title>LEMP System</title>
    
    <!-- Favicon -->
    <link rel="icon" href="<?php echo $basePath; ?>assets/img/logo.png" type="image/png">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<?php echo $basePath; ?>assets/css/style.css">
    <link rel="stylesheet" href="<?php echo $basePath; ?>assets/css/dark-mode.css">

    <style>
    /* Logo styling */
    .logo {
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
    }

    .logo-img {
        height: 45px;
        width: auto;
        transition: transform 0.3s ease;
    }
    
    .logo:hover .logo-img {
        transform: scale(1.1);
    }

    /* Theme toggle styling */
    .theme-toggle {
        display: flex;
        align-items: center;
    }

    .theme-toggle i {
        margin-right: 5px;
        transition: transform 0.3s ease;
    }

    .dark-mode .theme-toggle i.fa-sun {
        color: #f1c40f;
    }

    /* Fixed navigation styling */
    .nav-menu {
        display: flex;
        list-style: none;
        align-items: center;
    }
    
    .nav-item {
        margin-left: 1.5rem;
    }
    
    .nav-link {
        color: #333;
        text-decoration: none;
        font-weight: 500;
        padding: 0.5rem 0;
        position: relative;
        transition: all 0.3s ease;
    }
    
    .nav-link:hover,
    .nav-link.active {
        color: #3498db;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .logo-img {
            height: 35px;
        }

        .theme-label {
            display: none;
        }

        .theme-toggle i {
            margin-right: 0;
        }
    }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <nav class="navbar">
                <a href="<?php echo $basePath; ?>index.php" class="logo" title="LEMP Docker">
                    <img src="<?php echo $basePath; ?>assets/img/logo.png" alt="LEMP Docker Logo" class="logo-img">
                </a>
                
                <ul class="nav-menu">
                    <li class="nav-item">
                        <a href="<?php echo $basePath; ?>index.php" class="nav-link <?php echo isActivePage('index.php'); ?>">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo $basePath; ?>views/list.php" class="nav-link <?php echo isActivePage('list.php'); ?>">
                            <i class="fas fa-list"></i> List
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo $basePath; ?>views/create.php" class="nav-link <?php echo isActivePage('create.php'); ?>">
                            <i class="fas fa-plus-circle"></i> Create
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo $basePath; ?>views/setup.php" class="nav-link <?php echo isActivePage('setup.php'); ?>">
                            <i class="fas fa-database"></i> DB Config
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link theme-toggle" onclick="toggleDarkMode(); return false;">
                            <i class="fas fa-moon"></i> <span class="theme-label">Dark Mode</span>
                        </a>
                    </li>
                </ul>
                
                <div class="mobile-toggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </nav>
        </div>
    </header>
    
    <?php
    // Display flash messages if any
    if (isset($_SESSION['message'])) {
        $messageType = isset($_SESSION['message_type']) ? $_SESSION['message_type'] : 'success';
        echo '<div class="container">';
        echo '<div class="alert alert-' . $messageType . '">';
        echo $_SESSION['message'];
        echo '<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
        echo '</div>';
        echo '</div>';
        
        // Clear the message after displaying it
        unset($_SESSION['message']);
        unset($_SESSION['message_type']);
    }
    ?> 