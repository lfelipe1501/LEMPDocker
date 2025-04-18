document.addEventListener('DOMContentLoaded', function() {
    const darkModeToggle = document.getElementById('darkModeToggle');
    const htmlElement = document.documentElement;
    
    // Check for saved dark mode preference
    const isDarkMode = localStorage.getItem('darkMode') === 'enabled';
    
    // Set initial state
    if (isDarkMode) {
        htmlElement.classList.add('dark-mode');
        darkModeToggle.checked = true;
    }
    
    // Toggle dark mode when switch is clicked
    darkModeToggle.addEventListener('change', function() {
        if (this.checked) {
            htmlElement.classList.add('dark-mode');
            localStorage.setItem('darkMode', 'enabled');
        } else {
            htmlElement.classList.remove('dark-mode');
            localStorage.setItem('darkMode', 'disabled');
        }
    });
}); 