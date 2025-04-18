    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3 class="footer-title">LEMPDocker</h3>
                    <p>A simple LEMP stack application example using Docker.</p>
                </div>
                
                <div class="footer-section">
                    <h3 class="footer-title">Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="<?php echo $basePath; ?>index.php" class="footer-link"><i class="fas fa-home"></i> Home</a></li>
                        <li><a href="<?php echo $basePath; ?>views/list.php" class="footer-link"><i class="fas fa-list"></i> List Records</a></li>
                        <li><a href="<?php echo $basePath; ?>views/create.php" class="footer-link"><i class="fas fa-plus-circle"></i> Create Record</a></li>
                        <li><a href="<?php echo $basePath; ?>views/setup.php" class="footer-link"><i class="fas fa-database"></i> Database Config</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3 class="footer-title">Contact</h3>
                    <p>Need help? Contact us.</p>
                    <p><i class="fas fa-envelope"></i> <a href="mailto:lfelipe1501@gmail.com" class="footer-link">lfelipe1501@gmail.com</a></p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; <?php echo date('Y'); ?> LEMPDocker. All rights reserved.</p>
                <div class="social-links">
                    <a href="https://github.com/lfelipe1501/LEMPDocker" class="social-link" target="_blank"><i class="fab fa-github"></i></a>
                    <a href="https://twitter.com/lfelipe1501" class="social-link" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="https://linkedin.com/in/lfelipe1501" class="social-link" target="_blank"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Custom JS -->
    <script src="<?php echo $basePath; ?>assets/js/main.js"></script>

    <style>
        .footer {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 3rem 0 1.5rem;
        }
        
        .footer-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        
        .footer-section {
            flex: 1;
            min-width: 250px;
            margin-bottom: 1.5rem;
            padding-right: 2rem;
        }
        
        .footer-title {
            color: #3498db;
            margin-bottom: 1.2rem;
            font-size: 1.2rem;
            position: relative;
        }
        
        .footer-links {
            list-style: none;
            padding: 0;
        }
        
        .footer-links li {
            margin-bottom: 0.8rem;
        }
        
        .footer-link {
            color: #bdc3c7;
            text-decoration: none;
            transition: color 0.3s;
            display: inline-block;
        }
        
        .footer-link:hover {
            color: #3498db;
        }
        
        .footer-bottom {
            border-top: 1px solid #34495e;
            padding-top: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .social-links {
            display: flex;
            gap: 1rem;
        }
        
        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: #34495e;
            color: #ecf0f1;
            transition: all 0.3s;
        }
        
        .social-link:hover {
            background-color: #3498db;
            transform: translateY(-3px);
        }
        
        /* Dark mode compatibility */
        .dark-mode .footer {
            background-color: #1a1a2e;
        }
        
        .dark-mode .footer-title {
            color: #4ca1ff;
        }
        
        .dark-mode .footer-link {
            color: #d1d1d1;
        }
        
        .dark-mode .footer-link:hover {
            color: #4ca1ff;
        }
        
        .dark-mode .footer-bottom {
            border-top-color: #16213e;
        }
        
        .dark-mode .social-link {
            background-color: #16213e;
        }
        
        .dark-mode .social-link:hover {
            background-color: #4ca1ff;
        }
        
        @media (max-width: 768px) {
            .footer-content {
                flex-direction: column;
            }
            
            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }
            
            .social-links {
                margin-top: 1rem;
                justify-content: center;
            }
        }
    </style>
</body>
</html> 