<?php
require_once 'config/database.php';

// Get team ID from URL parameter
$team_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($team_id > 0) {
    // Get team logo from database
    $stmt = $pdo->prepare("SELECT team_logo FROM teams WHERE team_id = ?");
    $stmt->execute([$team_id]);
    $logo = $stmt->fetchColumn();
    
    if ($logo) {
        // Set appropriate headers
        header('Content-Type: image/png');
        header('Content-Length: ' . strlen($logo));
        
        // Output the image data
        echo $logo;
        exit;
    }
}

// If no image found, output a default image or error
header('HTTP/1.1 404 Not Found');
exit;
?> 
