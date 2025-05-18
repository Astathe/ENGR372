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
    SELECT DISTINCT 
        t.tournament_name,
        t.tournament_logo,
        MIN(m.match_date) as tournament_start,
        CASE 
            WHEN EXISTS (
                SELECT 1 FROM matches m2 
                WHERE m2.tournament_id = t.tournament_id 
                AND m2.round = 'Grand Final' 
                AND m2.winner_id = ?
            ) THEN '1st'
            WHEN EXISTS (
                SELECT 1 FROM matches m2 
                WHERE m2.tournament_id = t.tournament_id 
                AND m2.round = 'Grand Final' 
                AND (m2.team1_id = ? OR m2.team2_id = ?) 
                AND m2.winner_id != ?
            ) THEN '2nd'
            WHEN EXISTS (
                SELECT 1 FROM matches m2 
                WHERE m2.tournament_id = t.tournament_id 
                AND m2.round = 'Semi Finals' 
                AND (m2.team1_id = ? OR m2.team2_id = ?) 
                AND m2.winner_id != ?
            ) THEN '3rd-4th'
            ELSE 'Participant'
        END as placement,
        CASE 
            WHEN EXISTS (
                SELECT 1 FROM matches m2 
                WHERE m2.tournament_id = t.tournament_id 
                AND m2.round = 'Grand Final' 
                AND m2.winner_id = ?
            ) THEN t.first_place_prize
            WHEN EXISTS (
                SELECT 1 FROM matches m2 
                WHERE m2.tournament_id = t.tournament_id 
                AND m2.round = 'Grand Final' 
                AND (m2.team1_id = ? OR m2.team2_id = ?) 
                AND m2.winner_id != ?
            ) THEN t.second_place_prize
            WHEN EXISTS (
                SELECT 1 FROM matches m2 
                WHERE m2.tournament_id = t.tournament_id 
                AND m2.round = 'Semi Finals' 
                AND (m2.team1_id = ? OR m2.team2_id = ?) 
                AND m2.winner_id != ?
            ) THEN t.third_place_prize
            ELSE 0
        END as prize
    FROM tournaments t
    JOIN matches m ON t.tournament_id = m.tournament_id
    WHERE m.team1_id = ? OR m.team2_id = ?
    GROUP BY t.tournament_id, t.tournament_name, t.tournament_logo, t.first_place_prize, t.second_place_prize, t.third_place_prize
    ORDER BY tournament_start DESC
");
$stmt->execute([
    $team_id, // For 1st place check
    $team_id, $team_id, $team_id, // For 2nd place check
    $team_id, $team_id, $team_id, // For 3rd-4th place check
    $team_id, // For 1st place prize
    $team_id, $team_id, $team_id, // For 2nd place prize
    $team_id, $team_id, $team_id, // For 3rd place prize
    $team_id, $team_id // For main WHERE clause
]);
$tournament_history = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($team['team_name']); ?> - Solidpedia</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="script.js" defer></script>
</head>
<body>
    <div class="wallpaper" style="background-image: url('images/tms1.jpeg');"></div>
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
                        <th>Logo</th>
                        <th>Date</th>
                        <th>Placement</th>
                        <th>Prize</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($tournament_history as $history): ?>
                    <tr class="placement-<?php echo strtolower(str_replace('-', '', $history['placement'])); ?>">
                        <td><?php echo htmlspecialchars($history['tournament_name']); ?></td>
                        <td><img src="<?php echo htmlspecialchars($history['tournament_logo']); ?>" alt="Tournament Logo" class="tournament-logo-small"></td>
                        <td><?php echo date('F Y', strtotime($history['tournament_start'])); ?></td>
                        <td><?php echo $history['placement']; ?></td>
                        <td><?php echo $history['prize'] > 0 ? '$' . number_format($history['prize'], 2) : '-'; ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </section>
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
