document.addEventListener('DOMContentLoaded', function() {
    // Initialize any components that need JavaScript
    initializeAlerts();
    initializeDropdowns();
    setupFormValidation();
    
    // Toggle mobile menu
    const mobileToggle = document.querySelector('.mobile-toggle');
    const navMenu = document.querySelector('.nav-menu');
    
    if (mobileToggle) {
        mobileToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            mobileToggle.classList.toggle('active');
        });
    }
    
    // Close alert messages
    const alertCloseButtons = document.querySelectorAll('.alert .close');
    alertCloseButtons.forEach(button => {
        button.addEventListener('click', function() {
            const alert = this.closest('.alert');
            alert.style.opacity = '0';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 300);
        });
    });

    // Initialize dark mode based on system preference or saved preference
    initTheme();
});

/**
 * Initialize alert dismissal functionality
 */
function initializeAlerts() {
    const alerts = document.querySelectorAll('.alert');
    
    alerts.forEach(alert => {
        if (alert.querySelector('.close')) {
            alert.querySelector('.close').addEventListener('click', function() {
                alert.style.opacity = '0';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 300);
            });
        }
    });
}

/**
 * Initialize dropdown functionality for mobile navigation
 */
function initializeDropdowns() {
    const toggleButton = document.querySelector('.mobile-toggle');
    const navMenu = document.querySelector('.nav-menu');
    
    if (toggleButton && navMenu) {
        toggleButton.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            toggleButton.classList.toggle('active');
        });
    }
}

/**
 * Set up form validation
 */
function setupFormValidation() {
    const forms = document.querySelectorAll('form.needs-validation');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            form.classList.add('was-validated');
        }, false);
    });
}

/**
 * Display a notification message
 * 
 * @param {string} message - The message to display
 * @param {string} type - The type of message (success, warning, danger)
 * @param {number} duration - Duration in milliseconds
 */
function showNotification(message, type = 'success', duration = 3000) {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    // Show notification
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    // Hide and remove notification after duration
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, duration);
}

/**
 * Make an AJAX request
 * 
 * @param {string} url - The URL to send the request to
 * @param {string} method - The HTTP method (GET, POST, etc.)
 * @param {object} data - The data to send with the request
 * @param {function} callback - The function to call when the request is complete
 */
function ajaxRequest(url, method = 'GET', data = null, callback = null) {
    const xhr = new XMLHttpRequest();
    
    xhr.open(method, url, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    
    xhr.onload = function() {
        if (xhr.status >= 200 && xhr.status < 300) {
            if (callback) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    callback(null, response);
                } catch (e) {
                    callback(null, xhr.responseText);
                }
            }
        } else {
            if (callback) {
                callback(new Error(`Request failed with status ${xhr.status}`), null);
            }
        }
    };
    
    xhr.onerror = function() {
        if (callback) {
            callback(new Error('Request failed'), null);
        }
    };
    
    if (data) {
        const params = new URLSearchParams();
        
        for (const key in data) {
            if (data.hasOwnProperty(key)) {
                params.append(key, data[key]);
            }
        }
        
        xhr.send(params.toString());
    } else {
        xhr.send();
    }
}

// Dark mode functionality
function initTheme() {
    const darkModeToggle = document.querySelector('a[onclick*="toggleDarkMode"]');
    const darkModeIcon = darkModeToggle ? darkModeToggle.querySelector('i') : null;
    const themeLabel = darkModeToggle ? darkModeToggle.querySelector('.theme-label') : null;
    
    // Check for saved theme preference and source
    let userPreference = localStorage.getItem('theme');
    let themeSource = localStorage.getItem('themeSource') || 'auto';
    
    // If theme source is auto or there's no saved preference, use system preference
    if (themeSource === 'auto' || !userPreference) {
        const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
        userPreference = prefersDarkMode ? 'dark' : 'light';
        
        // Set the theme source as 'auto'
        localStorage.setItem('themeSource', 'auto');
        localStorage.setItem('theme', userPreference);
    }
    
    // Apply the theme
    applyTheme(userPreference, darkModeIcon, themeLabel);
    
    // Listen for system preference changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        // Only apply if the theme source is auto
        if (localStorage.getItem('themeSource') === 'auto') {
            const newTheme = e.matches ? 'dark' : 'light';
            localStorage.setItem('theme', newTheme);
            applyTheme(newTheme, darkModeIcon, themeLabel);
        }
    });
}

// Function to apply theme
function applyTheme(theme, icon, label) {
    if (theme === 'dark') {
        document.body.classList.add('dark-mode');
        if (icon) {
            icon.classList.remove('fa-moon');
            icon.classList.add('fa-sun');
        }
        if (label) {
            label.textContent = 'Light Mode';
        }
    } else {
        document.body.classList.remove('dark-mode');
        if (icon) {
            icon.classList.remove('fa-sun');
            icon.classList.add('fa-moon');
        }
        if (label) {
            label.textContent = 'Dark Mode';
        }
    }
}

// Function to toggle dark mode
function toggleDarkMode() {
    const darkModeToggle = document.querySelector('a[onclick*="toggleDarkMode"]');
    const darkModeIcon = darkModeToggle ? darkModeToggle.querySelector('i') : null;
    const themeLabel = darkModeToggle ? darkModeToggle.querySelector('.theme-label') : null;
    
    // Toggle the dark mode class on the body
    const isDarkMode = document.body.classList.toggle('dark-mode');
    const newTheme = isDarkMode ? 'dark' : 'light';
    
    // Update icon and label
    if (darkModeIcon) {
        if (isDarkMode) {
            darkModeIcon.classList.remove('fa-moon');
            darkModeIcon.classList.add('fa-sun');
            if (themeLabel) {
                themeLabel.textContent = 'Light Mode';
            }
        } else {
            darkModeIcon.classList.remove('fa-sun');
            darkModeIcon.classList.add('fa-moon');
            if (themeLabel) {
                themeLabel.textContent = 'Dark Mode';
            }
        }
    }
    
    // Save user preference
    localStorage.setItem('theme', newTheme);
    localStorage.setItem('themeSource', 'manual'); // User manually changed the theme
    
    return false;
} 