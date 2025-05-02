<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Website</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="script.js" defer></script>
</head>
<body>
    <div class="wallpaper" style="background-image: url('images/image1.jpg');"></div>
    <nav class="top-bar">
        <div class="logo">
            <a href="#">My Website</a>
        </div>
        <ul class="nav-links">
            <li><a href="/index.html" class="active">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Services</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
        <div class="mobile-menu">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </nav>
    <main>
        <div class="item-grid">
            <a href="#" class="item-box">
                <div class="item-image">
                    <img src="images/item1.png" alt="Item 1">
                </div>
                <h3 class="item-title">Ziraat Türkiye Kupası</h3>
            </a>
            <a href="./tournament.html" class="item-box">
                <div class="item-image">
                    <img src="images/item2.jpg" alt="Item 2">
                </div>
                <h3 class="item-title">PGL Major Copenhagen 2024</h3>
            </a>
            <a href="#" class="item-box">
                <div class="item-image">
                    <img src="images/item3.jpg" alt="Item 3">
                </div>
                <h3 class="item-title">Item 3</h3>
            </a>
            <a href="#" class="item-box">
                <div class="item-image">
                    <img src="images/item4.jpg" alt="Item 4">
                </div>
                <h3 class="item-title">Item 4</h3>
            </a>
            <a href="#" class="item-box">
                <div class="item-image">
                    <img src="images/item5.jpg" alt="Item 5">
                </div>
                <h3 class="item-title">Item 5</h3>
            </a>
            <a href="#" class="item-box">
                <div class="item-image">
                    <img src="images/item6.jpg" alt="Item 6">
                </div>
                <h3 class="item-title">Item 6</h3>
            </a>
        </div>
    </main>
    <footer class="footer">
        <div class="footer-content">
            <div class="logo">
                <a href="#">My Website</a>
            </div>
            <ul class="nav-links">
                <li><a href="#" class="active">Home</a></li>
                <li><a href="#">About</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 My Website. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
