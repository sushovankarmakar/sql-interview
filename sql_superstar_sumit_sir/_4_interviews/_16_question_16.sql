DROP TABLE activity;

CREATE TABLE activity (
    player_id INT, 
    device_id INT, 
    event_date DATE, 
    games_played INT 
)

INSERT INTO activity (player_id, device_id, event_date, games_played) VALUES 
(1, 2, '2016-03-01', 5), 
(1, 2, '2016-03-02', 6), 
(2, 3, '2017-06-25', 1), 
(3, 1, '2016-03-01', 0), 
(3, 4, '2016-07-03', 5);

SELECT * FROM activity AS a; 

-- 1. Find Install date for each player_id
-- 2. Now we need to find out that, if player_id: 1 logged in on the next day or not
-- 3. Final output with aggregation on install_date

WITH install_dates AS ( -- 1. Find Install date for each player_id
	SELECT 
	    a.player_id, 
	    MIN(a.event_date) AS install_date 
	FROM activity AS a  
	GROUP BY a.player_id
),
retention_results AS ( -- 2. Now we need to find out that, if player_id: 1 logged in on the next day or not
	SELECT 
		d.player_id, 
		d.install_date, 
		CASE 
			WHEN a.event_date IS NOT NULL THEN 1 ELSE 0    
		END AS is_retained 
	FROM install_dates AS d 
	LEFT JOIN activity AS a 
	ON d.player_id = a.player_id 
	AND DATE_ADD(d.install_date, INTERVAL 1 DAY) = a.event_date
)
SELECT 
	r.install_date AS install_dt, 
	COUNT(r.player_id) AS installs, 
	ROUND(AVG(r.is_retained), 2) AS Day1_retention 
FROM retention_results r 
GROUP BY r.install_date; -- 3. Final output with aggregation on install_date







SELECT 
	i.install_date AS install_dt, 
	COUNT(i.player_id) AS installs, 
	(SELECT 
		(COUNT(a1.player_id) / COUNT(i.player_id))
	FROM activity AS a1 
	WHERE a1.event_date = DATE_ADD(i.install_date, INTERVAL 1 DAY)
	) AS Day1_retention  
FROM install_dates AS i 
GROUP BY i.install_date; 

