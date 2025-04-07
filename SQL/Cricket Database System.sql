create database cricket
use cricket
-- 1. Players Table
CREATE TABLE players (player_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    nationality VARCHAR(50),
    role VARCHAR(50),  
    batting_style VARCHAR(50),
    bowling_style VARCHAR(50))

-- 2. Teams Table
CREATE TABLE teams (team_id INT PRIMARY KEY,
    team_name VARCHAR(100),
    captain_id INT,  
    FOREIGN KEY (captain_id) REFERENCES players(player_id))

-- 3. Matches Table
CREATE TABLE matches (match_id INT PRIMARY KEY,
    tournament_id INT,
    team1_id INT,  
    team2_id INT,  
    match_date DATE,
    venue VARCHAR(100),
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id))

-- 4. Match Scores Table
CREATE TABLE match_scores (score_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    team_id INT,
    runs INT,
    wickets INT,
    overs FLOAT,
    catches INT,
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id))

-- 5. Tournaments Table
CREATE TABLE tournaments (tournament_id INT PRIMARY KEY,
    tournament_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    location VARCHAR(100))

-- 6. Team Members Table 
CREATE TABLE team_members (team_id INT,
    player_id INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    PRIMARY KEY (team_id, player_id))

-- 7. Match Results Table
CREATE TABLE match_results (match_id INT PRIMARY KEY,
    winning_team_id INT,
    result VARCHAR(50),  
    margin VARCHAR(50),  
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (winning_team_id) REFERENCES teams(team_id))

-- 1. Insert Players
INSERT INTO players (player_id, first_name, last_name, birthdate, nationality, role, batting_style, bowling_style)
VALUES 
(1, 'Virat', 'Kohli', '1988-11-05', 'India', 'Batsman', 'Right-handed', 'Right-arm medium'),
(2, 'Rohit', 'Sharma', '1987-04-30', 'India', 'Batsman', 'Right-handed', 'Right-arm off-break'),
(3, 'Shikhar', 'Dhawan', '1985-12-05', 'India', 'Batsman', 'Left-handed', 'Right-arm medium'),
(4, 'MS', 'Dhoni', '1981-07-07', 'India', 'Wicketkeeper', 'Right-handed', 'Right-arm medium'),
(5, 'Jasprit', 'Bumrah', '1993-12-06', 'India', 'Bowler', 'Right-handed', 'Right-arm fast'),
(6, 'Kane', 'Williamson', '1990-08-08', 'New Zealand', 'Batsman', 'Right-handed', 'Right-arm off-break'),
(7, 'Martin', 'Guptill', '1986-09-30', 'New Zealand', 'Batsman', 'Right-handed', 'Right-arm medium'),
(8, 'Ross', 'Taylor', '1984-03-08', 'New Zealand', 'Batsman', 'Right-handed', 'Right-arm off-break'),
(9, 'Ben', 'Stokes', '1991-06-04', 'England', 'All-rounder', 'Left-handed', 'Right-arm fast-medium'),
(10, 'Joe', 'Root', '1990-12-30', 'England', 'Batsman', 'Right-handed', 'Right-arm off-break'),
(11, 'David', 'Warner', '1986-10-27', 'Australia', 'Batsman', 'Left-handed', 'Right-arm medium'),
(12, 'Steven', 'Smith', '1989-06-02', 'Australia', 'Batsman', 'Right-handed', 'Right-arm leg-spin'),
(13, 'Pat', 'Cummins', '1993-05-08', 'Australia', 'Bowler', 'Right-handed', 'Right-arm fast'),
(14, 'Shaheen', 'Afridi', '2000-04-06', 'Pakistan', 'Bowler', 'Left-handed', 'Left-arm fast'),
(15, 'Babar', 'Azam', '1994-10-15', 'Pakistan', 'Batsman', 'Right-handed', 'Right-arm medium')

-- 2. Insert Teams
INSERT INTO teams (team_id, team_name, captain_id)
VALUES 
(1, 'India', 1),
(2, 'New Zealand', 6),
(3, 'England', 9),
(4, 'Australia', 11),
(5, 'Pakistan', 14)

-- 3. Insert Tournaments
INSERT INTO tournaments (tournament_id, tournament_name, start_date, end_date, location)
VALUES
(1, 'ICC World Cup 2023', '2023-10-01', '2023-11-15', 'India'),
(2, 'Ashes 2023', '2023-12-05', '2024-01-15', 'Australia')

-- 4. Insert Matches
INSERT INTO matches (match_id, tournament_id, team1_id, team2_id, match_date, venue)
VALUES 
(1, 1, 1, 2, '2023-10-02', 'Eden Gardens, Kolkata'),
(2, 1, 3, 4, '2023-10-03', 'Melbourne Cricket Ground'),
(3, 2, 4, 5, '2023-12-06', 'Sydney Cricket Ground'),
(4, 2, 1, 3, '2023-12-08', 'Lord’s Cricket Ground')

-- 5. Insert Match Scores
INSERT INTO match_scores (score_id, match_id, player_id, team_id, runs, wickets, overs, catches)
VALUES 
(1, 1, 1, 1, 85, 0, 10, 1),
(2, 1, 6, 2, 75, 0, 10, 0),
(3, 2, 9, 3, 100, 0, 10, 1),
(4, 2, 11, 4, 120, 1, 9, 2),
(5, 3, 13, 4, 0, 5, 10, 1),
(6, 3, 15, 5, 65, 1, 10, 0),
(7, 4, 12, 1, 40, 1, 10, 2),
(8, 4, 10, 3, 10, 0, 10, 0)

-- 6. Insert Team Members
INSERT INTO team_members (team_id, player_id)
VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), 
(2, 6), (2, 7), (2, 8), 
(3, 9), (3, 10), 
(4, 11), (4, 12), (4, 13), 
(5, 14), (5, 15)

-- 7. Insert Match Results
INSERT INTO match_results (match_id, winning_team_id, result, margin)
VALUES 
(1, 1, 'India won', 'by 50 runs'),
(2, 3, 'England won', 'by 20 runs'),
(3, 4, 'Australia won', 'by 10 wickets'),
(4, 3, 'England won', 'by 5 wickets')

-- 1. Get All Players in a Specific Team (e.g., Team India)
SELECT p.first_name, p.last_name
FROM players p
JOIN team_members tm ON p.player_id = tm.player_id
WHERE tm.team_id = 1;  -- India

-- 2. Get the Top Scorer in a Match (e.g., Match 1)
SELECT p.first_name, p.last_name, ms.runs
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
WHERE ms.match_id = 1
ORDER BY ms.runs DESC
LIMIT 1;

-- 3. Get the Player with Most Wickets in a Match (e.g., Match 2)
SELECT p.first_name, p.last_name, ms.wickets
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
WHERE ms.match_id = 2
ORDER BY ms.wickets DESC
LIMIT 1;

-- 4. Get All Matches Played by a Specific Player
SELECT m.match_id, m.match_date, t1.team_name AS team1, t2.team_name AS team2, ms.runs
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id
JOIN match_scores ms ON ms.match_id = m.match_id
JOIN players p ON ms.player_id = p.player_id
WHERE p.first_name = 'Virat' AND p.last_name = 'Kohli';

-- 5. Get the Total Runs Scored by a Player (e.g., Rohit Sharma)
SELECT p.first_name, p.last_name, SUM(ms.runs) AS total_runs
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
WHERE p.first_name = 'Rohit' AND p.last_name = 'Sharma'
GROUP BY p.player_id;

-- 6. Get the Number of Catches Taken by a Player 
SELECT p.first_name, p.last_name, SUM(ms.catches) AS total_catches
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
WHERE p.first_name = 'MS' AND p.last_name = 'Dhoni'
GROUP BY p.player_id;

-- 7. Get Matches Won by a Specific Team (e.g., Australia)
SELECT m.match_id, m.match_date, t1.team_name AS team1, t2.team_name AS team2, mr.result
FROM match_results mr
JOIN matches m ON mr.match_id = m.match_id
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id
WHERE mr.winning_team_id = 4;  -- Australia

-- 8. Get the Best Bowling Performance in a Match 
SELECT p.first_name, p.last_name, ms.wickets, ms.overs
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
WHERE ms.match_id = 1
ORDER BY ms.wickets DESC, ms.overs DESC
LIMIT 1;

-- 9. Get All Players in a Specific Tournament 
SELECT p.first_name, p.last_name
FROM players p
JOIN match_scores ms ON p.player_id = ms.player_id
JOIN matches m ON ms.match_id = m.match_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
WHERE t.tournament_name = 'ICC World Cup 2023';

-- 10. Get the Total Runs Scored by Each Player in a Tournament 
SELECT p.first_name, p.last_name, SUM(ms.runs) AS total_runs
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
JOIN matches m ON ms.match_id = m.match_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
WHERE t.tournament_name = 'ICC World Cup 2023'
GROUP BY p.player_id
ORDER BY total_runs DESC;

-- 11. Get the Number of Matches Played by a Team 
SELECT t.team_name, COUNT(m.match_id) AS total_matches
FROM matches m
JOIN teams t ON m.team1_id = t.team_id OR m.team2_id = t.team_id
WHERE t.team_name = 'India'
GROUP BY t.team_name;

-- 12. Get the Match Result Between Two Specific Teams 
SELECT m.match_id, m.match_date, mr.result, mr.margin
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id
JOIN match_results mr ON m.match_id = mr.match_id
WHERE (t1.team_name = 'India' AND t2.team_name = 'New Zealand')
OR (t1.team_name = 'New Zealand' AND t2.team_name = 'India');

-- 13. Get the Highest Wicket-Taker in a Tournament (e.g., ICC World Cup 2023)
SELECT p.first_name, p.last_name, SUM(ms.wickets) AS total_wickets
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
JOIN matches m ON ms.match_id = m.match_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
WHERE t.tournament_name = 'ICC World Cup 2023'
GROUP BY p.player_id
ORDER BY total_wickets DESC
LIMIT 1;

-- 14. Get the Player with Most Catches in a Tournament 
SELECT p.first_name, p.last_name, SUM(ms.catches) AS total_catches
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
JOIN matches m ON ms.match_id = m.match_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
WHERE t.tournament_name = 'ICC World Cup 2023'
GROUP BY p.player_id
ORDER BY total_catches DESC
LIMIT 1;

-- 15. Get the Player Who Played the Most Matches in a Tournament
SELECT p.first_name, p.last_name, COUNT(ms.match_id) AS total_matches
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
JOIN matches m ON ms.match_id = m.match_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
WHERE t.tournament_name = 'ICC World Cup 2023'
GROUP BY p.player_id
ORDER BY total_matches DESC
LIMIT 1;

-- 16. Get the Team That Won the Most Matches in a Tournament 
SELECT t.team_name, COUNT(mr.match_id) AS total_wins
FROM match_results mr
JOIN teams t ON mr.winning_team_id = t.team_id
JOIN matches m ON mr.match_id = m.match_id
JOIN tournaments t2 ON m.tournament_id = t2.tournament_id
WHERE t2.tournament_name = 'ICC World Cup 2023'
GROUP BY t.team_name
ORDER BY total_wins DESC
LIMIT 1;

-- 17. Get the Player's Performance in a Specific Match 
SELECT p.first_name, p.last_name, ms.runs, ms.wickets, ms.overs, ms.catches
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
WHERE ms.match_id = 1;

-- 18. Get the Players Who Played for Both Teams in a Specific Match 
SELECT p.first_name, p.last_name, t.team_name
FROM players p
JOIN match_scores ms ON p.player_id = ms.player_id
JOIN teams t ON ms.team_id = t.team_id
WHERE ms.match_id = 1
ORDER BY t.team_name;

-- 19. Get the Total Number of Wickets Taken in a Match 
SELECT SUM(ms.wickets) AS total_wickets
FROM match_scores ms
WHERE ms.match_id = 2;

-- 20. Get the Player's Batting Average (Runs/Wickets) in a Tournament  
SELECT p.first_name, p.last_name, 
       SUM(ms.runs) / COUNT(DISTINCT ms.match_id) AS batting_average
FROM match_scores ms
JOIN players p ON ms.player_id = p.player_id
JOIN matches m ON ms.match_id = m.match_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
WHERE t.tournament_name = 'ICC World Cup 2023'
GROUP BY p.player_id
ORDER BY batting_average DESC
LIMIT 1;
 