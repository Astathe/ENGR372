$(document).ready(function() {
    // Mobile menu toggle
    $('.mobile-menu').click(function() {
        $(this).toggleClass('active');
        $('.nav-links').toggleClass('active');
    });

    // Close mobile menu when clicking outside
    $(document).click(function(event) {
        if (!$(event.target).closest('.top-bar').length) {
            $('.mobile-menu').removeClass('active');
            $('.nav-links').removeClass('active');
        }
    });

    // Handle navigation item clicks
    $('.nav-links a').click(function(e) {
        $('.nav-links a').removeClass('active');
        $(this).addClass('active');
        
        // Close mobile menu when a link is clicked
        $('.mobile-menu').removeClass('active');
        $('.nav-links').removeClass('active');
    });
}); 