CREATE TABLE users2 (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    birthdate TIMESTAMP
);

INSERT INTO users2 (id, name, birthdate) VALUES
(1, 'Alice', '1995-05-15'),
(2, 'Bob', '1985-03-20'),
(3, 'Charlie', '2005-07-10'),
(4, 'David', '1955-11-30'),
(5, 'Eve', '2015-09-25'),
(6, 'Frank', '1935-02-14'),
(7, 'Grace', '1975-12-01');

CREATE TABLE search_events (
    search_id INTEGER PRIMARY KEY,
    query VARCHAR(255),
    has_clicked BOOLEAN,
    user_id INTEGER,
    search_time TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users2(id)
);

INSERT INTO search_events (search_id, query, has_clicked, user_id, search_time) VALUES
(1, 'travel', TRUE, 1, '2021-03-15 10:00:00'),
(2, 'books', FALSE, 1, '2021-03-15 11:00:00'),
(3, 'cars', TRUE, 2, '2021-05-20 14:30:00'),
(4, 'tech', TRUE, 2, '2021-05-20 15:00:00'),
(5, 'games', FALSE, 3, '2021-07-10 16:45:00'),
(6, 'music', FALSE, 3, '2021-07-10 17:00:00'),
(7, 'retirement', TRUE, 4, '2021-09-05 09:15:00'),
(8, 'health', FALSE, 4, '2021-09-05 10:00:00'),
(9, 'toys', FALSE, 5, '2021-11-25 13:20:00'),
(10, 'genealogy', TRUE, 6, '2021-12-01 11:30:00'),
(11, 'history', TRUE, 6, '2021-12-01 12:00:00'),
(12, 'finance', TRUE, 7, '2021-02-15 08:45:00'),
(13, 'investing', FALSE, 7, '2021-02-15 09:00:00');

SELECT * FROM users2;
SELECT * FROM search_events;


-- Given two tables, search_events and users, 
-- write a query to find the three age groups 
-- (bucketed by decade: 0-9, 10-19, 20-29, …,80-89, 90-99, with the end point included) with the highest clickthrough rate in 2021. 

-- If two or more groups have the same clickthrough rate, the older group should have priority.

-- Hint: 
-- if a user that clicked the link on 1/1/2021 who is 29 years old on that day and has a birthday tomorrow on 2/1/2021, they fall into the [20-29] category. 
-- If the same user clicked on another link on 2/1/2021, he turned 30 and will fall into the [30-39] category.


WITH age_details AS (
	SELECT
		se.search_id,
		se.has_clicked,
		EXTRACT(YEAR FROM age(se.search_time, u.birthdate)) AS age
	FROM users2 u 
	JOIN search_events se 
	ON u.id = se.user_id
    WHERE EXTRACT(YEAR FROM se.search_time) = 2021
),
age_group_details AS (
	SELECT 
		ad.has_clicked,
		CASE
			WHEN age >= 0 AND age <= 9 THEN '0-9'
			WHEN age >= 10 AND age <= 19 THEN '10-19'
			WHEN age >= 20 AND age <= 29 THEN '20-29'
			WHEN age >= 30 AND age <= 39 THEN '30-39'
			WHEN age >= 40 AND age <= 49 THEN '40-49'
			WHEN age >= 50 AND age <= 59 THEN '50-59'
			WHEN age >= 60 AND age <= 69 THEN '60-69'
			WHEN age >= 70 AND age <= 79 THEN '70-79'
			WHEN age >= 80 AND age <= 89 THEN '80-89'
			WHEN age >= 90 AND age <= 99 THEN '90-99'
		END AS age_group
	FROM age_details ad
    WHERE age BETWEEN 0 AND 99
),
click_metrics AS (
	SELECT 
		agd.age_group,
		COUNT(*) AS total_searches,
        SUM(CASE WHEN agd.has_clicked THEN 1 ELSE 0 END) AS clicks
	FROM age_group_details agd
	GROUP BY agd.age_group
)
SELECT 
	age_group,
	ROUND(COALESCE(clicks * 100.0 / NULLIF(total_searches, 0), 0), 2) AS ctr
FROM click_metrics 
ORDER BY 
	ctr DESC, 
	age_group DESC
LIMIT 3;


