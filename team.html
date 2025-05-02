<?php
require_once 'config/database.php';

// Get team ID from URL parameter
$team_id = isset($_GET['id']) ? (int)$_GET['id'] : 1;

// Get team details
$stmt = $pdo->prepare("SELECT * FROM teams WHERE team_id = ?");
$stmt->execute([$team_id]);
$team = $stmt->fetch(PDO::FETCH_ASSOC);

// Get team players
$stmt = $pdo->prepare("SELECT * FROM players WHERE team_id = ?");
$stmt->execute([$team_id]);
$players = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Get team's tournament history
$stmt = $pdo->prepare("
    SELECT t.tournament_name, m.match_date, m.round, 
           CASE 
               WHEN m.winner_id = ? THEN '1st'
               WHEN m.team1_id = ? OR m.team2_id = ? THEN '2nd'
               ELSE '3rd'
           END as placement,
           CASE 
               WHEN m.winner_id = ? THEN t.first_place_prize
               WHEN m.team1_id = ? OR m.team2_id = ? THEN t.second_place_prize
               ELSE t.third_place_prize
           END as prize
    FROM matches m
    JOIN tournaments t ON m.tournament_id = t.tournament_id
    WHERE (m.team1_id = ? OR m.team2_id = ?)
    ORDER BY m.match_date DESC
");
$stmt->execute([$team_id, $team_id, $team_id, $team_id, $team_id, $team_id, $team_id, $team_id]);
$tournament_history = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($team['team_name']); ?> - Team Profile</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="script.js" defer></script>
</head>
<body>
    <div class="wallpaper" style="background-image: url('images/tms1.jpeg');"></div>
    <nav class="top-bar">
        <div class="logo">
            <a href="#">My Website</a>
        </div>
        <ul class="nav-links">
            <li><a href="/index.php" class="active">Home</a></li>
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
        <div class="team-header">
            <div class="team-info">
                <h1><?php echo htmlspecialchars($team['team_name']); ?></h1>
                <div class="roster-section">
                    <div class="roster-table">
                        <h2>Active Roster</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Nickname</th>
                                    <th>Role</th>
                                    <th>Country</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($players as $player): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($player['player_name']); ?></td>
                                    <td><?php echo htmlspecialchars($player['player_nickname']); ?></td>
                                    <td><?php echo htmlspecialchars($player['player_role']); ?></td>
                                    <td><?php echo htmlspecialchars($player['player_country']); ?></td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="team-info-right">
                <div class="team-logo">
                    <img src="<?php echo htmlspecialchars($team['team_logo']); ?>" alt="<?php echo htmlspecialchars($team['team_name']); ?> Logo">
                </div>
            </div>
        </div>

        <section class="tournament-history">
            <h2>Tournament History</h2>
            <table class="tournament-table">
                <thead>
                    <tr>
                        <th>Tournament</th>
                        <th>Date</th>
                        <th>Placement</th>
                        <th>Prize</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($tournament_history as $history): ?>
                    <tr class="placement-<?php echo strtolower($history['placement']); ?>">
                        <td><?php echo htmlspecialchars($history['tournament_name']); ?></td>
                        <td><?php echo date('F Y', strtotime($history['match_date'])); ?></td>
                        <td><?php echo $history['placement']; ?></td>
                        <td>$<?php echo number_format($history['prize'], 2); ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </section>
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
