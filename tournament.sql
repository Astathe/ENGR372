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
INSERT INTO tournaments (tournament_name, tournament_logo, total_prize_pool, first_place_prize, second_place_prize, third_place_prize, format, caster1_name, caster2_name) 
VALUES ('PGL Major Copenhagen 2024', './images/tournament-logo1.png', 1250000.00, 500000.00, 175000.00, 80000.00, 'Single Elimination', 'Richard Lewis', 'Eefje Depoortere');

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

-- Insert ELEAGUE Major Atlanta 2017 tournament
INSERT INTO tournaments (tournament_name, tournament_logo, total_prize_pool, first_place_prize, second_place_prize, third_place_prize, format, caster1_name, caster2_name) 
VALUES ('ELEAGUE Major Atlanta 2017', './images/eleague2017.png', 1000000.00, 500000.00, 150000.00, 70000.00, 'Single Elimination', 'Anders Blume', 'Auguste Massonnat');

-- Insert teams for ELEAGUE Major Atlanta 2017
INSERT INTO teams (team_name, team_logo) VALUES
('Astralis', './images/astralis.png'),
('Virtus.pro', './images/virtuspro.png'),
('SK Gaming', './images/sk.png'),
('North', './images/north.png'),
('Natus Vincere', './images/navi.png'),
('FaZe Clan', './images/faze.png'),
('Gambit Esports', './images/gambit.png'),
('Fnatic', './images/fnatic.png');

-- Insert tournament bracket data for ELEAGUE Major Atlanta 2017
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
-- Quarter Finals
(2, 'Quarter Finals', 1, 9, 16, 1, 0, 9, 5),    -- Astralis vs Fnatic
(2, 'Quarter Finals', 2, 10, 15, 1, 0, 10, 5),  -- Virtus.pro vs Gambit
(2, 'Quarter Finals', 3, 11, 14, 1, 0, 11, 6),  -- SK Gaming vs FaZe
(2, 'Quarter Finals', 4, 12, 13, 1, 0, 12, 6),  -- North vs NaVi
-- Semi Finals
(2, 'Semi Finals', 5, 9, 10, 1, 0, 9, 7),       -- Astralis vs Virtus.pro
(2, 'Semi Finals', 6, 11, 12, 1, 0, 11, 7),     -- SK Gaming vs North
-- Grand Final
(2, 'Grand Final', 7, 9, 11, 1, 0, 9, NULL);    -- Astralis vs SK Gaming

-- Insert match results for ELEAGUE Major Atlanta 2017
INSERT INTO matches (tournament_id, round, match_date, team1_id, team2_id, team1_score, team2_score, winner_id) VALUES
-- Quarter Finals
(2, 'Quarter Finals', '2017-01-27 15:00:00', 9, 16, 16, 8, 9),    -- Astralis vs Fnatic
(2, 'Quarter Finals', '2017-01-27 18:00:00', 10, 15, 16, 14, 10), -- Virtus.pro vs Gambit
(2, 'Quarter Finals', '2017-01-28 15:00:00', 11, 14, 16, 10, 11), -- SK Gaming vs FaZe
(2, 'Quarter Finals', '2017-01-28 18:00:00', 12, 13, 16, 14, 12), -- North vs NaVi
-- Semi Finals
(2, 'Semi Finals', '2017-01-29 15:00:00', 9, 10, 16, 8, 9),      -- Astralis vs Virtus.pro
(2, 'Semi Finals', '2017-01-29 18:00:00', 11, 12, 16, 14, 11),   -- SK Gaming vs North
-- Grand Final
(2, 'Grand Final', '2017-01-29 21:00:00', 9, 11, 16, 12, 9);     -- Astralis vs SK Gaming

-- Insert 6 more tournaments
INSERT INTO tournaments (tournament_name, tournament_logo, total_prize_pool, first_place_prize, second_place_prize, third_place_prize, format, caster1_name, caster2_name) VALUES 
('ESL Pro League Season 19', './images/item2.jpg', 850000.00, 400000.00, 180000.00, 80000.00, 'Single Elimination', 'Henry Greer', 'Matthew Trivett'),
('IEM Katowice 2024', './images/item2.jpg', 1000000.00, 400000.00, 180000.00, 90000.00, 'Single Elimination', 'Alex Richardson', 'Chad Burchill'),
('BLAST Premier Spring Final 2024', './images/item2.jpg', 750000.00, 300000.00, 150000.00, 75000.00, 'Single Elimination', 'Anders Blume', 'Jason O''Toole'),
('DreamHack Masters 2024', './images/item2.jpg', 250000.00, 100000.00, 50000.00, 25000.00, 'Single Elimination', 'Vince Hill', 'Mohan Govindasamy'),
('StarLadder Berlin Major 2024', './images/item2.jpg', 1000000.00, 500000.00, 150000.00, 70000.00, 'Single Elimination', 'James Bardolph', 'Daniel Kapadia'),
('ESL One Cologne 2024', './images/item2.jpg', 1000000.00, 400000.00, 200000.00, 100000.00, 'Single Elimination', 'Alex Richardson', 'Harry Russell');

-- Tournament 3: ESL Pro League Season 19
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
(3, 'Quarter Finals', 1, 1, 4, 2, 0, 1, 5),
(3, 'Quarter Finals', 2, 2, 3, 2, 1, 2, 5),
(3, 'Quarter Finals', 3, 5, 8, 2, 0, 5, 6),
(3, 'Quarter Finals', 4, 6, 7, 2, 1, 6, 6),
(3, 'Semi Finals', 5, 1, 2, 2, 1, 1, 7),
(3, 'Semi Finals', 6, 5, 6, 2, 0, 5, 7),
(3, 'Grand Final', 7, 1, 5, 2, 1, 1, NULL);

-- Tournament 4: IEM Katowice 2024
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
(4, 'Quarter Finals', 1, 3, 6, 2, 0, 3, 5),
(4, 'Quarter Finals', 2, 4, 5, 2, 1, 4, 5),
(4, 'Quarter Finals', 3, 7, 2, 2, 0, 7, 6),
(4, 'Quarter Finals', 4, 8, 1, 2, 1, 8, 6),
(4, 'Semi Finals', 5, 3, 4, 2, 1, 3, 7),
(4, 'Semi Finals', 6, 7, 8, 2, 0, 7, 7),
(4, 'Grand Final', 7, 3, 7, 2, 1, 3, NULL);

-- Tournament 5: BLAST Premier Spring Final 2024
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
(5, 'Quarter Finals', 1, 2, 7, 2, 0, 2, 5),
(5, 'Quarter Finals', 2, 1, 8, 2, 1, 1, 5),
(5, 'Quarter Finals', 3, 4, 5, 2, 0, 4, 6),
(5, 'Quarter Finals', 4, 3, 6, 2, 1, 3, 6),
(5, 'Semi Finals', 5, 2, 1, 2, 1, 2, 7),
(5, 'Semi Finals', 6, 4, 3, 2, 0, 4, 7),
(5, 'Grand Final', 7, 2, 4, 2, 1, 2, NULL);

-- Tournament 6: DreamHack Masters 2024
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
(6, 'Quarter Finals', 1, 5, 2, 2, 0, 5, 5),
(6, 'Quarter Finals', 2, 6, 1, 2, 1, 6, 5),
(6, 'Quarter Finals', 3, 7, 4, 2, 0, 7, 6),
(6, 'Quarter Finals', 4, 8, 3, 2, 1, 8, 6),
(6, 'Semi Finals', 5, 5, 6, 2, 1, 5, 7),
(6, 'Semi Finals', 6, 7, 8, 2, 0, 7, 7),
(6, 'Grand Final', 7, 5, 7, 2, 1, 5, NULL);

-- Tournament 7: StarLadder Berlin Major 2024
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
(7, 'Quarter Finals', 1, 1, 8, 2, 0, 1, 5),
(7, 'Quarter Finals', 2, 2, 7, 2, 1, 2, 5),
(7, 'Quarter Finals', 3, 3, 6, 2, 0, 3, 6),
(7, 'Quarter Finals', 4, 4, 5, 2, 1, 4, 6),
(7, 'Semi Finals', 5, 1, 2, 2, 1, 1, 7),
(7, 'Semi Finals', 6, 3, 4, 2, 0, 3, 7),
(7, 'Grand Final', 7, 1, 3, 2, 1, 1, NULL);

-- Tournament 8: ESL One Cologne 2024
INSERT INTO tournament_bracket (tournament_id, round_name, match_order, team1_id, team2_id, team1_score, team2_score, winner_id, next_round_match_order) VALUES
(8, 'Quarter Finals', 1, 4, 5, 2, 0, 4, 5),
(8, 'Quarter Finals', 2, 3, 6, 2, 1, 3, 5),
(8, 'Quarter Finals', 3, 2, 7, 2, 0, 2, 6),
(8, 'Quarter Finals', 4, 1, 8, 2, 1, 1, 6),
(8, 'Semi Finals', 5, 4, 3, 2, 1, 4, 7),
(8, 'Semi Finals', 6, 2, 1, 2, 0, 2, 7),
(8, 'Grand Final', 7, 4, 2, 2, 1, 4, NULL);

-- Insert corresponding matches for Tournament 3-8
INSERT INTO matches (tournament_id, round, match_date, team1_id, team2_id, team1_score, team2_score, winner_id) VALUES
-- ESL Pro League Season 19
(3, 'Quarter Finals', '2024-04-15 15:00:00', 1, 4, 16, 8, 1),
(3, 'Quarter Finals', '2024-04-15 18:00:00', 2, 3, 16, 14, 2),
(3, 'Quarter Finals', '2024-04-16 15:00:00', 5, 8, 16, 10, 5),
(3, 'Quarter Finals', '2024-04-16 18:00:00', 6, 7, 16, 14, 6),
(3, 'Semi Finals', '2024-04-17 15:00:00', 1, 2, 16, 12, 1),
(3, 'Semi Finals', '2024-04-17 18:00:00', 5, 6, 16, 10, 5),
(3, 'Grand Final', '2024-04-18 21:00:00', 1, 5, 16, 14, 1),

-- IEM Katowice 2024
(4, 'Quarter Finals', '2024-05-20 15:00:00', 3, 6, 16, 8, 3),
(4, 'Quarter Finals', '2024-05-20 18:00:00', 4, 5, 16, 14, 4),
(4, 'Quarter Finals', '2024-05-21 15:00:00', 7, 2, 16, 10, 7),
(4, 'Quarter Finals', '2024-05-21 18:00:00', 8, 1, 16, 14, 8),
(4, 'Semi Finals', '2024-05-22 15:00:00', 3, 4, 16, 12, 3),
(4, 'Semi Finals', '2024-05-22 18:00:00', 7, 8, 16, 10, 7),
(4, 'Grand Final', '2024-05-23 21:00:00', 3, 7, 16, 14, 3),

-- BLAST Premier Spring Final 2024
(5, 'Quarter Finals', '2024-06-10 15:00:00', 2, 7, 16, 8, 2),
(5, 'Quarter Finals', '2024-06-10 18:00:00', 1, 8, 16, 14, 1),
(5, 'Quarter Finals', '2024-06-11 15:00:00', 4, 5, 16, 10, 4),
(5, 'Quarter Finals', '2024-06-11 18:00:00', 3, 6, 16, 14, 3),
(5, 'Semi Finals', '2024-06-12 15:00:00', 2, 1, 16, 12, 2),
(5, 'Semi Finals', '2024-06-12 18:00:00', 4, 3, 16, 10, 4),
(5, 'Grand Final', '2024-06-13 21:00:00', 2, 4, 16, 14, 2),

-- DreamHack Masters 2024
(6, 'Quarter Finals', '2024-07-15 15:00:00', 5, 2, 16, 8, 5),
(6, 'Quarter Finals', '2024-07-15 18:00:00', 6, 1, 16, 14, 6),
(6, 'Quarter Finals', '2024-07-16 15:00:00', 7, 4, 16, 10, 7),
(6, 'Quarter Finals', '2024-07-16 18:00:00', 8, 3, 16, 14, 8),
(6, 'Semi Finals', '2024-07-17 15:00:00', 5, 6, 16, 12, 5),
(6, 'Semi Finals', '2024-07-17 18:00:00', 7, 8, 16, 10, 7),
(6, 'Grand Final', '2024-07-18 21:00:00', 5, 7, 16, 14, 5),

-- StarLadder Berlin Major 2024
(7, 'Quarter Finals', '2024-08-20 15:00:00', 1, 8, 16, 8, 1),
(7, 'Quarter Finals', '2024-08-20 18:00:00', 2, 7, 16, 14, 2),
(7, 'Quarter Finals', '2024-08-21 15:00:00', 3, 6, 16, 10, 3),
(7, 'Quarter Finals', '2024-08-21 18:00:00', 4, 5, 16, 14, 4),
(7, 'Semi Finals', '2024-08-22 15:00:00', 1, 2, 16, 12, 1),
(7, 'Semi Finals', '2024-08-22 18:00:00', 3, 4, 16, 10, 3),
(7, 'Grand Final', '2024-08-23 21:00:00', 1, 3, 16, 14, 1),

-- ESL One Cologne 2024
(8, 'Quarter Finals', '2024-09-15 15:00:00', 4, 5, 16, 8, 4),
(8, 'Quarter Finals', '2024-09-15 18:00:00', 3, 6, 16, 14, 3),
(8, 'Quarter Finals', '2024-09-16 15:00:00', 2, 7, 16, 10, 2),
(8, 'Quarter Finals', '2024-09-16 18:00:00', 1, 8, 16, 14, 1),
(8, 'Semi Finals', '2024-09-17 15:00:00', 4, 3, 16, 12, 4),
(8, 'Semi Finals', '2024-09-17 18:00:00', 2, 1, 16, 10, 2),
(8, 'Grand Final', '2024-09-18 21:00:00', 4, 2, 16, 14, 4);
