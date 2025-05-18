<?php
require_once 'config/database.php';

// Get all tournaments
$stmt = $pdo->query("SELECT * FROM tournaments ORDER BY tournament_id DESC");
$tournaments = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solidpedia</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="script.js" defer></script>
</head>
<body>
    <div class="wallpaper" style="background-image: url('images/image1.jpg');"></div>
    <nav class="top-bar">
        <div class="logo">
            <a href="/index.php">Solidpedia</a>
        </div>
        <ul class="nav-links">
            <li><a href="/index.php" class="active">Home</a></li>
        </ul>
        <div class="mobile-menu">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </nav>
    <main>
        <div class="item-grid">
            <?php foreach ($tournaments as $tournament): ?>
            <a href="tournament.php?id=<?php echo $tournament['tournament_id']; ?>" class="item-box">
                <div class="item-image">
                    <img src="<?php echo htmlspecialchars($tournament['tournament_logo']); ?>" alt="<?php echo htmlspecialchars($tournament['tournament_name']); ?>">
                </div>
                <h3 class="item-title"><?php echo htmlspecialchars($tournament['tournament_name']); ?></h3>
            </a>
            <?php endforeach; ?>
        </div>
    </main>
    <footer class="footer">
        <div class="footer-content">
            <div class="logo">
                <a href="#">Solidpedia</a>
            </div>
            <ul class="nav-links">
                <li><a href="#" class="active">Home</a></li>
            </ul>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 Solidpedia. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
