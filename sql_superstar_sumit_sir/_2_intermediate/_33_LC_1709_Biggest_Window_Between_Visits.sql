DROP TABLE lc_1709_user_visits;

CREATE TABLE lc_1709_user_visits (
    user_id INT,
    visit_date DATE
);

INSERT INTO lc_1709_user_visits (user_id, visit_date) VALUES
(1, '2020-11-28'),
(1, '2020-10-20'),
(1, '2020-12-03'),
(2, '2020-10-05'),
(2, '2020-12-09'),
(3, '2020-11-11');

-- Problem Description
-- We are given a table called UserVisits 
-- which contains logs of the dates that users visited a specific retailer. 
-- The table has two columns user_id and visit_date. 

-- We have to write an SQL query to 
-- find out the largest window of days between each visit 
-- and the one right after it (or today if we are considering the last visit) for each user_id. 
-- We return the result table ordered by user_id.

WITH next_visit_date_result AS (
	SELECT 
	    v.user_id, 
	    v.visit_date, 
	    LEAD(v.visit_date, 1, '2021-01-01') OVER (PARTITION BY v.user_id ORDER BY v.visit_date) AS next_visit_date 
	FROM lc_1709_user_visits v  
),
visit_gap_result AS (
	SELECT 
		nv.*,
		DATEDIFF(nv.next_visit_date, nv.visit_date) AS visit_gap 
	FROM next_visit_date_result nv
)
SELECT 
	vg.user_id, 
	MAX(vg.visit_gap) AS biggest_window 
FROM visit_gap_result vg 
GROUP BY vg.user_id 
ORDER BY vg.user_id;


-- (1, '2020-11-28'), '2020-10-20'
-- (1, '2020-10-20'), '2020-12-03'
-- (1, '2020-12-03'), '2026-03-05' 
-- (2, '2020-10-05'),
-- (2, '2020-12-09'),
-- (3, '2020-11-11');

