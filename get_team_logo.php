<?php
require_once 'config/database.php';

// Get team ID from URL parameter
$team_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($team_id > 0) {
    // Retrieve image from database
$sql = "SELECT image_data, image_type FROM images WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $image_id);
$stmt->execute();
$stmt->store_result();
$stmt->bind_result($image_data, $image_type);

if ($stmt->num_rows > 0) {
    $stmt->fetch();
    
    // Set the correct content type header
    header("Content-Type: " . $image_type);
    
    // Output the image data
    echo $image_data;
} else {
    // Image not found
    header("HTTP/1.0 404 Not Found");
    echo "Image not found";
}
        exit;
}

// If no image found, output a default image or error
header('HTTP/1.1 404 Not Found');
exit;
?> 