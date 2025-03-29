CREATE TABLE post_events (
    user_id INT,
    created_at TIMESTAMP,
    action VARCHAR(20)
);

INSERT INTO post_events VALUES
(1, '2020-01-01 10:00:00', 'post_enter'),
(1, '2020-01-01 10:05:00', 'post_submit'),
(2, '2020-01-01 11:00:00', 'post_enter'),
(2, '2020-01-01 11:10:00', 'post_canceled'),
(3, '2020-01-01 15:00:00', 'post_enter'),
(3, '2020-01-01 15:30:00', 'post_submit'),
(4, '2020-01-02 09:00:00', 'post_enter'),
(4, '2020-01-02 09:15:00', 'post_canceled'),
(5, '2020-01-02 10:00:00', 'post_enter'),
(5, '2020-01-02 10:10:00', 'post_canceled'),
(10, '2020-01-15 14:00:00', 'post_enter'),
(10, '2020-01-15 14:30:00', 'post_submit'),
(6, '2019-12-31 23:55:00', 'post_enter'),
(6, '2020-01-01 00:05:00', 'post_submit'),
(7, '2020-02-01 00:00:00', 'post_enter'),
(7, '2020-02-01 00:10:00', 'post_submit'),
(8, '2019-01-15 10:00:00', 'post_enter'),
(8, '2019-01-15 10:30:00', 'post_submit'),
(9, '2021-01-01 09:00:00', 'post_enter'),
(9, '2021-01-01 09:10:00', 'post_canceled');

SELECT * FROM post_events;


-- Write a query to get the post-success rate for each day in the month of January 2020
-- Post Success Rate is defined as the number of posts submitted (post_submit) divided by the number of posts entered (post_enter) for each day


WITH jan_posts AS (
	SELECT *, DATE(created_at) AS date 
	FROM post_events
	WHERE created_at LIKE '2020-01-%'
) ,
post_count AS (
	SELECT DISTINCT date,
	COUNT(CASE WHEN action = 'post_enter' THEN 1 ELSE NULL END) OVER (PARTITION BY date) AS total_enters,
	COUNT(CASE WHEN action = 'post_submit' THEN 1 ELSE NULL END) OVER (PARTITION BY date) AS total_submits 
	FROM jan_posts
)
SELECT 
	date,
	total_enters,
	total_submits,
	total_submits / NULLIF(total_enters, 0) AS success_rate
FROM post_count;

-- Replaced LIKE '2020-01-%' with proper date range
-- Used SUM with GROUP BY instead of window functions
-- Removed unnecessary DISTINCT

-- improved version of the SQL query with better performance and readability
WITH daily_stats AS (
    SELECT 
        DATE(created_at) AS date,
        SUM(CASE WHEN action = 'post_enter' THEN 1 ELSE 0 END) AS total_enters,
        SUM(CASE WHEN action = 'post_submit' THEN 1 ELSE 0 END) AS total_submits
    FROM post_events
    WHERE created_at >= '2020-01-01'
    AND created_at < '2020-02-01'
    GROUP BY DATE(created_at)
)
SELECT
    date,
    total_enters,
    total_submits,
    ROUND(
        CAST(total_submits AS DECIMAL) / NULLIF(total_enters, 0),
        2
    ) AS success_rate
FROM daily_stats
ORDER BY date;