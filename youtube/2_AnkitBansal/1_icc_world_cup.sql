
CREATE TABLE icc_world_cup
(
	team1 varchar(20),
	team2 varchar(20),
	winner varchar(20)
);

INSERT INTO icc_world_cup
(team1, team2, winner)
VALUES
('Ind', 'SL', 'Ind'),
('SL', 'Aus', 'Aus'),
('SA', 'Eng', 'Eng'),
('Eng', 'NZ', 'NZ'),
('Aus', 'Ind', 'Ind');

SELECT * FROM icc_world_cup iwc ;

SELECT team_name, 
count(*) AS matches_played, 
sum(win_flag) AS num_of_wins, 
count(*) - sum(win_flag) AS num_of_losses 
FROM
(
	(SELECT iwc.team1 AS team_name,
		CASE 
			WHEN iwc.team1 = iwc.winner THEN 1
			ELSE 0
		END AS win_flag
	FROM icc_world_cup iwc)
	UNION ALL
	(SELECT iwc.team2 AS team_name,
		CASE 
			WHEN iwc.team2 = iwc.winner THEN 1
			ELSE 0
		END AS win_flag
	FROM icc_world_cup iwc)
) AS win_flag_table
GROUP BY win_flag_table.team_name
ORDER BY num_of_wins DESC ;

