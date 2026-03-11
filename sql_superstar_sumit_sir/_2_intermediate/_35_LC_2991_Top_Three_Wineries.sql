CREATE TABLE wineries_lc_2991 (
    id      INT,
    country VARCHAR(50),
    points  INT,
    winery  VARCHAR(50)
);

INSERT INTO wineries_lc_2991 (id, country, points, winery) VALUES
(103, 'Australia', 84,  'WhisperingPines'),
(737, 'Australia', 85,  'GrapesGalore'),
(848, 'Australia', 100, 'HarmonyHill'),
(222, 'Hungary',   60,  'MoonlitCellars'),
(116, 'USA',       47,  'RoyalVines'),
(124, 'USA',       45,  'Eagle''sNest'),
(648, 'India',     69,  'SunsetVines'),
(894, 'USA',       39,  'RoyalVines'),
(677, 'USA',       9,   'PacificCrest');

SELECT * FROM wineries_lc_2991 w;

-- Write a solution to find the top three wineries in each country based on their total points. 
-- If multiple wineries have the same total points, order them by winery name in ascending order. 
-- If there's no second winery, output 'No Second Winery,' 
-- and if there's no third winery, output 'No Third Winery.'

-- Return the result table ordered by country in ascending order.

WITH total_points_results AS (
	SELECT 
		w.winery, 
		w.country, 
		SUM(w.points) AS total_points 
	FROM wineries_lc_2991 w 
	GROUP BY w.winery, w.country
),
rnk_results AS (
	SELECT 
		CONCAT(p.winery, " (", p.total_points , ")") AS winery, 
		p.country,  
		RANK() OVER (PARTITION BY p.country ORDER BY p.total_points DESC, p.winery) AS rnk
	FROM total_points_results p
) 
SELECT 
	r.country,  
	MAX((CASE WHEN r.rnk = 1 THEN r.winery END)) AS top_winery,  
	COALESCE(MAX((CASE WHEN r.rnk = 2 THEN r.winery END)), "No second winery") AS second_winery, 
	COALESCE(MAX((CASE WHEN r.rnk = 3 THEN r.winery END)), "No third winery") AS third_winery
FROM rnk_results r 
GROUP BY r.country; 



