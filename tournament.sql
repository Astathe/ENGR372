-- Create database
CREATE DATABASE IF NOT EXISTS tournament_db;
USE tournament_db;

-- Teams table
CREATE TABLE teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL,
    team_logo VARCHAR(255)
);

-- Players table
CREATE TABLE players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT,
    player_name VARCHAR(100) NOT NULL,
    player_nickname VARCHAR(50),
    player_role VARCHAR(50),
    player_country VARCHAR(50),
    player_photo VARCHAR(255),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- Tournaments table
CREATE TABLE tournaments (
    tournament_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_name VARCHAR(100) NOT NULL,
    tournament_logo VARCHAR(255),
    total_prize_pool DECIMAL(12,2),
    first_place_prize DECIMAL(12,2),
    second_place_prize DECIMAL(12,2),
    third_place_prize DECIMAL(12,2),
    format VARCHAR(50),
    start_date DATE,
    end_date DATE,
    caster1_name VARCHAR(100),
    caster2_name VARCHAR(100)
);

-- Tournament Bracket table
CREATE TABLE tournament_bracket (
    bracket_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT,
    round_name VARCHAR(50) NOT NULL,
    match_order INT NOT NULL,
    team1_id INT,
    team2_id INT,
    team1_score INT,
    team2_score INT,
    winner_id INT,
    next_round_match_order INT,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id),
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id),
    FOREIGN KEY (winner_id) REFERENCES teams(team_id)
);

-- Matches table
CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT,
    round VARCHAR(50) NOT NULL,
    match_date DATETIME,
    team1_id INT,
    team2_id INT,
    team1_score INT,
    team2_score INT,
    winner_id INT,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id),
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id),
    FOREIGN KEY (winner_id) REFERENCES teams(team_id)
);

-- Insert sample data for PGL Major Copenhagen 2024
INSERT INTO tournaments (tournament_name, total_prize_pool, first_place_prize, second_place_prize, third_place_prize, format, caster1_name, caster2_name) 
VALUES ('PGL Major Copenhagen 2024', 1250000.00, 500000.00, 175000.00, 80000.00, 'Single Elimination', 'Richard Lewis', 'Eefje Depoortere');

-- Insert sample teams with logo paths
INSERT INTO teams (team_name, team_logo) VALUES
('Team Spirit', './images/spirit.png'),
('FaZe Clan', './images/faze.png'),
('Team Vitality', './images/vitality.png'),
('Cloud9', './images/cloud9.png'),
('Eternal Fire', './images/eternalfire.png'),
('Natus Vincere', './images/navi.png'),
('G2 Esports', './images/g2.png'),
('MOUZ', './images/mouz.png');

-- Insert sample players
INSERT INTO players (team_id, player_name, player_nickname, player_role, player_country) VALUES
-- Team Spirit Players
(1, 'Leonid Vishnyakov', 'chopper', 'IGL', 'Russia'),
(1, 'Boris Vorobyev', 'magixx', 'Rifler', 'Russia'),
(1, 'Dmitry Sokolov', 'sh1ro', 'AWPer', 'Russia'),
(1, 'Danil Kryshkovets', 'donk', 'Rifler', 'Russia'),
(1, 'Myroslav Plakhotia', 'zont1x', 'Rifler', 'Ukraine'),

-- FaZe Clan Players
(2, 'Finn Andersen', 'karrigan', 'IGL', 'Denmark'),
(2, 'Håvard Nygaard', 'rain', 'Rifler', 'Norway'),
(2, 'Robin Kool', 'ropz', 'Rifler', 'Estonia'),
(2, 'Helvijs Saukants', 'broky', 'AWPer', 'Latvia'),
(2, 'Russel Van Dulken', 'Twistzz', 'Rifler', 'Canada'),

-- Team Vitality Players
(3, 'Dan Madesclaire', 'apEX', 'IGL', 'France'),
(3, 'Mathieu Herbaut', 'ZywOo', 'AWPer', 'France'),
(3, 'Peter Rasmussen', 'dupreeh', 'Rifler', 'Denmark'),
(3, 'Emil Reif', 'Magisk', 'Rifler', 'Denmark'),
(3, 'Lotan Giladi', 'Spinx', 'Rifler', 'Israel'),

-- Cloud9 Players
(4, 'Vladislav Gorshkov', 'nafany', 'IGL', 'Russia'),
(4, 'Timur Bletdinov', 'buster', 'Rifler', 'Russia'),
(4, 'Sergey Rykhtorov', 'Ax1Le', 'Rifler', 'Russia'),
(4, 'Dmitry Sokolov', 'sh1ro', 'AWPer', 'Russia'),
(4, 'Abay Khassenov', 'HObbit', 'Rifler', 'Kazakhstan'),

-- Eternal Fire Players
(5, 'Özgür Eker', 'woxic', 'AWPer', 'Turkey'),
(5, 'Buğra Arkın', 'Calyx', 'Rifler', 'Turkey'),
(5, 'Ismailcan Dörtkardeş', 'XANTARES', 'Rifler', 'Turkey'),
(5, 'Ahmet Karahoca', 'paz', 'Rifler', 'Turkey'),
(5, 'Ali Haydar Yalçın', 'MAJ3R', 'IGL', 'Turkey'),

-- Natus Vincere Players
(6, 'Kirill Mikhailov', 'Boombl4', 'IGL', 'Russia'),
(6, 'Oleksandr Kostyliev', 's1mple', 'AWPer', 'Ukraine'),
(6, 'Denis Sharipov', 'electronic', 'Rifler', 'Russia'),
(6, 'Valeriy Vakhovskiy', 'b1t', 'Rifler', 'Ukraine'),
(6, 'Ilya Zalutskiy', 'Perfecto', 'Rifler', 'Russia'),

-- G2 Esports Players
(7, 'Rasmus Nielsen', 'HooXi', 'IGL', 'Denmark'),
(7, 'Nemanja Kovač', 'huNter-', 'Rifler', 'Bosnia and Herzegovina'),
(7, 'Nikola Kovač', 'NiKo', 'Rifler', 'Bosnia and Herzegovina'),
(7, 'Ilya Osipov', 'm0NESY', 'AWPer', 'Russia'),
(7, 'Justin Savage', 'jks', 'Rifler', 'Australia'),

-- MOUZ Players
(8, 'Christopher de Jong', 'dexter', 'IGL', 'Australia'),
(8, 'Ádám Torzsás', 'torzsi', 'AWPer', 'Hungary'),
(8, 'David Čerňanský', 'frozen', 'Rifler', 'Slovakia'),
(8, 'Jon de Castro', 'JDC', 'Rifler', 'Germany'),
(8, 'Dorian Berman', 'xertioN', 'Rifler', 'Israel');

-- Insert tournament bracket data
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
-- Quarter Finals
(1, 'Quarter Finals', 1, 2, 1, 2, 1, 2, 5),
(1, 'Quarter Finals', 2, 3, 4, 2, 0, 3, 5),
(1, 'Quarter Finals', 3, 5, 6, 0, 2, 6, 6),
(1, 'Quarter Finals', 4, 7, 8, 2, 0, 7, 6),
-- Semi Finals
(1, 'Semi Finals', 5, 2, 3, 2, 1, 2, 7),
(1, 'Semi Finals', 6, 6, 7, 2, 1, 6, 7),
-- Grand Final
(1, 'Grand Final', 7, 2, 6, 1, 2, 6, NULL);

-- Insert sample matches
INSERT INTO matches (tournament_id, round, match_date, team1_id, team2_id, team1_score, team2_score, winner_id) VALUES
(1, 'Quarter Finals', '2024-03-28 21:55:00', 2, 1, 2, 1, 2),
(1, 'Quarter Finals', '2024-03-28 21:55:00', 3, 4, 2, 0, 3),
(1, 'Quarter Finals', '2024-03-28 21:55:00', 5, 6, 0, 2, 6),
(1, 'Quarter Finals', '2024-03-28 21:55:00', 7, 8, 2, 0, 7),
(1, 'Semi Finals', '2024-03-29 21:55:00', 2, 3, 2, 1, 2),
(1, 'Semi Finals', '2024-03-29 21:55:00', 6, 7, 2, 1, 6),
(1, 'Grand Final', '2024-03-30 21:55:00', 2, 6, 1, 2, 6); 
