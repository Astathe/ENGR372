<?php
require_once 'config/database.php';

// Get tournament ID from URL parameter
$tournament_id = isset($_GET['id']) ? (int)$_GET['id'] : 1;

// Get tournament details for the selected tournament
$stmt = $pdo->prepare("SELECT * FROM tournaments WHERE tournament_id = ?");
$stmt->execute([$tournament_id]);
$tournament = $stmt->fetch(PDO::FETCH_ASSOC);

// Get teams that participated in this tournament
$stmt = $pdo->prepare("
    SELECT DISTINCT t.* 
    FROM teams t
    JOIN tournament_bracket tb ON t.team_id = tb.team1_id OR t.team_id = tb.team2_id
    WHERE tb.tournament_id = ?
    ORDER BY t.team_name
");
$stmt->execute([$tournament_id]);
$teams = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Get tournament bracket for the selected tournament
$stmt = $pdo->prepare("SELECT * FROM tournament_bracket WHERE tournament_id = ? ORDER BY match_order");
$stmt->execute([$tournament_id]);
$bracket = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Get matches for the selected tournament
$stmt = $pdo->prepare("SELECT * FROM matches WHERE tournament_id = ? ORDER BY match_date");
$stmt->execute([$tournament_id]);
$matches = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($tournament['tournament_name']); ?> - Solidpedia</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="script.js" defer></script>
</head>
<body>
    <div class="wallpaper" style="background-image: url('<?php echo htmlspecialchars($tournament['tournament_logo']); ?>');"></div>
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
        <div class="tournament-header">
            <div class="tournament-info">
                <h1><?php echo htmlspecialchars($tournament['tournament_name']); ?></h1>
                <div class="tournament-details">
                    <div class="detail-item">
                        <h3>Format</h3>
                        <p><?php echo htmlspecialchars($tournament['format']); ?></p>
                    </div>
                    <div class="detail-item">
                        <h3>Prize Pool: $<?php echo number_format($tournament['total_prize_pool'], 2); ?> USD</h3>
                        <p>1st Place: $<?php echo number_format($tournament['first_place_prize'], 2); ?> USD</p>
                        <p>2nd Place: $<?php echo number_format($tournament['second_place_prize'], 2); ?> USD</p>
                        <p>3rd Place: $<?php echo number_format($tournament['third_place_prize'], 2); ?> USD</p>
                    </div>
                    <div class="detail-item">
                        <h3>Casters</h3>
                        <p><?php echo htmlspecialchars($tournament['caster1_name']); ?></p>
                        <p><?php echo htmlspecialchars($tournament['caster2_name']); ?></p>
                    </div>
                </div>
            </div>
            <div class="tournament-logo">
                <img src="<?php echo htmlspecialchars($tournament['tournament_logo']); ?>" alt="Tournament Logo">
            </div>
        </div>

        <section class="participants">
            <h2>Participating Teams</h2>
            <div class="team-grid">
                <?php foreach ($teams as $team): ?>
                <a class="team-card" href="team.php?id=<?php echo $team['team_id']; ?>">
                    <img src="<?php echo htmlspecialchars($team['team_logo']); ?>" alt="<?php echo htmlspecialchars($team['team_name']); ?>">
                    <h3><?php echo htmlspecialchars($team['team_name']); ?></h3>
                </a>
                <?php endforeach; ?>
            </div>
        </section>

        <section class="match-results">
            <h2>Recent Matches</h2>
            <div class="matches-list">
                <?php foreach ($matches as $match): 
                    $stmt = $pdo->prepare("SELECT team_name, team_logo FROM teams WHERE team_id = ?");
                    $stmt->execute([$match['team1_id']]);
                    $team1 = $stmt->fetch(PDO::FETCH_ASSOC);
                    $stmt->execute([$match['team2_id']]);
                    $team2 = $stmt->fetch(PDO::FETCH_ASSOC);
                ?>
                <div class="match-card">
                    <div class="match-teams">
                        <div class="team">
                            <img src="<?php echo htmlspecialchars($team1['team_logo']); ?>" alt="<?php echo htmlspecialchars($team1['team_name']); ?>">
                        </div>
                        <div class="score"><?php echo $match['team1_score']; ?> - <?php echo $match['team2_score']; ?></div>
                        <div class="team">
                            <img src="<?php echo htmlspecialchars($team2['team_logo']); ?>" alt="<?php echo htmlspecialchars($team2['team_name']); ?>">
                        </div>
                    </div>
                    <div class="match-info">
                        <span class="match-date"><?php echo date('F j, Y - H:i', strtotime($match['match_date'])); ?></span>
                        <span class="match-stage"><?php echo htmlspecialchars($match['round']); ?></span>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
        </section>

        <section class="tournament-bracket">
            <h2>Tournament Bracket</h2>
            <div class="bracket-container">
                <?php
                $current_round = '';
                foreach ($bracket as $match):
                    if ($current_round != $match['round_name']):
                        if ($current_round != '') echo '</div>';
                        echo '<div class="round ' . strtolower(str_replace(' ', '-', $match['round_name'])) . '">';
                        echo '<h3>' . htmlspecialchars($match['round_name']) . '</h3>';
                        $current_round = $match['round_name'];
                    endif;
                    
                    $stmt = $pdo->prepare("SELECT team_name, team_logo FROM teams WHERE team_id = ?");
                    $stmt->execute([$match['team1_id']]);
                    $team1 = $stmt->fetch(PDO::FETCH_ASSOC);
                    $stmt->execute([$match['team2_id']]);
                    $team2 = $stmt->fetch(PDO::FETCH_ASSOC);
                ?>
                <div class="match">
                    <div class="team <?php echo $match['winner_id'] == $match['team1_id'] ? 'winner' : ''; ?>">
                        <img src="<?php echo htmlspecialchars($team1['team_logo']); ?>" alt="<?php echo htmlspecialchars($team1['team_name']); ?>">
                        <?php echo htmlspecialchars($team1['team_name']); ?>
                        <span class="score"><?php echo $match['team1_score']; ?></span>
                    </div>
                    <div class="team <?php echo $match['winner_id'] == $match['team2_id'] ? 'winner' : ''; ?>">
                        <img src="<?php echo htmlspecialchars($team2['team_logo']); ?>" alt="<?php echo htmlspecialchars($team2['team_name']); ?>">
                        <?php echo htmlspecialchars($team2['team_name']); ?>
                        <span class="score"><?php echo $match['team2_score']; ?></span>
                    </div>
                </div>
                <?php endforeach; ?>
                </div>
            </div>
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
