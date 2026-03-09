CREATE TABLE fifa_wc_matches (
	match_id INT PRIMARY KEY, 
	home_team VARCHAR(50), 
	away_team VARCHAR(50), 
	home_score INT, 
	away_score INT, 
	match_date DATE
);

INSERT INTO fifa_wc_matches (match_id, home_team, away_team, home_score, away_score, match_date) VALUES
(1, 'Argentina', 'Saudi Arabia', 2, 1, '2022-11-22'),
(2, 'France', 'Australia', 3, 1, '2022-11-22'),
(3, 'Brazil', 'Serbia', 2, 2, '2022-11-24'),
(4, 'England', 'Iran', 3, 0, '2022-11-21'),
(5, 'Mexico', 'Argentina', 1, 2, '2022-11-26'),
(6, 'Denmark', 'France', 0, 2, '2022-11-26'),
(7, 'Switzerland', 'Brazil', 1, 0, '2022-11-28'),
(8, 'USA', 'England', 1, 1, '2022-11-25'),
(9, 'Poland', 'Argentina', 1, 2, '2022-11-30'),
(10, 'Tunisia', 'France', 0, 2, '2022-11-30'),
(11, 'Argentina', 'Mexico', 3, 1, '2022-12-03'),
(12, 'Argentina', 'Poland', 2, 0, '2023-03-28'),
(13, 'Brazil', 'Switzerland', 2, 1, '2022-12-05'),
(14, 'Switzerland', 'Brazil', 2, 0, '2023-06-11'),
(15, 'France', 'Denmark', 2, 0, '2022-12-11'),
(16, 'Denmark', 'France', 1, 2, '2023-09-14'),
(17, 'Poland', 'England', 0, 1, '2022-12-12'),
(18, 'England', 'Poland', 2, 1, '2023-10-21'),
(19, 'USA', 'England', 2, 2, '2023-01-12'),
(20, 'Iran', 'England', 1, 2, '2022-12-13'),
(21, 'England', 'Iran', 3, 2, '2023-02-27');


-- Identify teams that have won all their matches and show the total number of goals scored by these teams in those matches.
WITH home_team_win_goals AS (
	SELECT 
		m.home_team AS team, 
		m.home_score AS goal_scored 
	FROM fifa_wc_matches m 
	WHERE m.home_score > m.away_score
),
away_team_win_goals AS (
	SELECT 
		m.away_team AS team, 
		m.away_score AS goal_scored 
	FROM fifa_wc_matches m 
	WHERE m.home_score < m.away_score
), 
winning_team_goals AS (
	SELECT * FROM home_team_win_goals 
	UNION ALL 
	SELECT * FROM away_team_win_goals 
)
SELECT 
	t.team, 
	COUNT(t.team) AS matches_won, 
	SUM(t.goal_scored) AS total_goal_scored 
FROM winning_team_goals t 
GROUP BY t.team 
HAVING matches_won = (
	SELECT COUNT(*) 
	FROM fifa_wc_matches m 
	WHERE m.home_team = t.team OR m.away_team = t.team
);



-- Find all pairs of teams that have played against each other at least twice, where one team has won all the matches
WITH winners AS (
	SELECT 
		f.home_team,
		f.away_team,
		CASE 
			WHEN f.home_score > f.away_score THEN f.home_team 
			WHEN f.home_score < f.away_score THEN f.away_team 
			ELSE "draw" 
		END AS winner 
	FROM fifa_wc_matches f
)
SELECT 
	least(w.home_team, w.away_team) AS team1, 
	greatest(w.home_team, w.away_team) AS team2, 
	COUNT(*) AS num_of_matches_played, 
	GROUP_CONCAT(w.winner SEPARATOR ', ') AS winner_list 
FROM winners w 
GROUP BY team1, team2 
HAVING num_of_matches_played >= 2 
AND winner_list NOT LIKE '%draw%' 
AND COUNT(DISTINCT w.winner) = 1;






