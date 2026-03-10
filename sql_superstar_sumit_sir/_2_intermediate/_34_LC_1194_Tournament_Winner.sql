DROP TABLE Players;

CREATE TABLE players (
  player_id INT PRIMARY KEY,
  group_id  INT NOT NULL
);

CREATE TABLE matches (
  match_id      INT PRIMARY KEY,
  first_player  INT NOT NULL,
  second_player INT NOT NULL,
  first_score   INT NOT NULL,
  second_score  INT NOT NULL
);

INSERT INTO players (player_id, group_id) VALUES
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);

INSERT INTO matches (match_id, first_player, second_player, first_score, second_score) VALUES
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);


SELECT * FROM matches m;


-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.

-- approach 1: shorter version
WITH all_players AS (
	SELECT first_player AS player_id, first_score AS score FROM matches m 
	UNION ALL
	SELECT second_player AS player_id, second_score AS score FROM matches m
),
score_agg_rnk AS (
	SELECT 
		p.player_id, 
		p.group_id,
		RANK() OVER (PARTITION BY p.group_id ORDER BY SUM(a.score) DESC, p.player_id ASC) AS rnk
	FROM players p 
	JOIN all_players a 
	ON p.player_id = a.player_id 
	GROUP BY p.player_id
)
SELECT 
	r.group_id,  
	r.player_id 
FROM score_agg_rnk r
WHERE r.rnk = 1;




-- approach 2:
WITH total_score_per_player AS (
	SELECT 
		p.player_id, 
		p.group_id, 
		SUM(CASE 
			WHEN p.player_id = m.first_player THEN m.first_score ELSE m.second_score 
		END) AS total_score 
	FROM players p 
	JOIN matches m 
	ON p.player_id IN (m.first_player, m.second_player) 
	GROUP BY p.player_id, p.group_id
),
rnk_by_total_score AS (
	SELECT 
		s.group_id,
		s.player_id, 
		RANK() OVER (PARTITION BY s.group_id 
			ORDER BY s.total_score DESC, s.player_id ASC) AS rnk 
	FROM total_score_per_player s
)
SELECT 
	r.group_id,
	r.player_id  
FROM rnk_by_total_score r 
WHERE r.rnk = 1;


