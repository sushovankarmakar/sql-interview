CREATE TABLE matches_2173 (
    player_id INT NOT NULL,
    match_day DATE NOT NULL,
    result VARCHAR(10) NOT NULL
);

INSERT INTO matches_2173 (player_id, match_day, result) VALUES
(1, '2022-01-17', 'Win'),
(1, '2022-01-18', 'Win'),
(1, '2022-01-25', 'Win'),
(1, '2022-01-31', 'Draw'),
(1, '2022-02-08', 'Win'),
(2, '2022-02-06', 'Lose'),
(2, '2022-02-08', 'Lose'),
(3, '2022-03-30', 'Win');

SELECT * 
FROM matches_2173 m;



WITH row_num_result AS (
	SELECT 
		m.*, 
		ROW_NUMBER() OVER (PARTITION BY m.player_id ORDER BY m.match_day) AS rn_player, 
		ROW_NUMBER() OVER (PARTITION BY m.player_id, m.result ORDER BY m.match_day) AS rn_player_result 
	FROM matches_2173 m 
	ORDER BY m.player_id, m.match_day
),
diff_result AS (
	SELECT 
		r.*,
		r.rn_player - r.rn_player_result AS diff  
	FROM row_num_result r
),
diff_agg AS (
	SELECT 
		d.player_id, 
		d.diff,
		COUNT(*) AS cnt 
	FROM diff_result d 
	WHERE d.result = 'Win' 
	GROUP BY d.player_id, d.diff
)
SELECT 
	m.player_id, 
	COALESCE(MAX(da.cnt), 0) AS longest_streak 
FROM matches_2173 m 
LEFT JOIN diff_agg da 
ON m.player_id = da.player_id 
GROUP BY m.player_id; 


WITH grp_num_result AS (
	SELECT 
		m.*, 
		SUM(
			CASE WHEN m.result != 'Win' THEN 1 ELSE 0 END
		) OVER (
			PARTITION BY m.player_id 
			ORDER BY m.match_day
		) AS grp_num 
	FROM matches_2173 m
),
wins_only AS (
	SELECT * 
	FROM grp_num_result g 
	WHERE g.`result` = 'Win'
),
grp_len_agg AS (
	SELECT 
		w.player_id, w.grp_num, COUNT(w.grp_num) AS grp_len 
	FROM wins_only w 
	GROUP BY w.player_id, w.grp_num
)
SELECT 
	m.player_id, 
	COALESCE(MAX(a.grp_len), 0) AS longest_streak 
FROM matches_2173 AS m 
LEFT JOIN grp_len_agg a 
ON m.player_id = a.player_id 
GROUP BY m.player_id;

	-- )
SELECT 
	m.player_id,
	COALESCE(s.longest_streak, 0) AS longest_streak 
FROM matches_2173 AS m 
LEFT JOIN longest_streak_result s 
ON m.player_id = s.player_id; 




