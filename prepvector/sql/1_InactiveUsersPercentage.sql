CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO users (user_id, name) VALUES
(1, 'John'),
(2, 'Jane'),
(3, 'Bob'),
(4, 'Alice'),
(5, 'Mike');

CREATE TABLE events (
    event_id INT PRIMARY KEY,
    user_id INT,
    action VARCHAR(10),
    created_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO events (event_id, user_id, action, created_at) VALUES
(1, 1, 'post', '2024-01-01 10:00:00'),
(2, 1, 'post', '2024-01-01 14:00:00'),
(3, 1, 'post', '2024-01-02 09:00:00'),
(4, 2, 'like', '2024-01-01 10:05:00'),
(5, 2, 'comment', '2024-01-01 10:10:00'),
(6, 2, 'post', '2024-01-01 15:00:00'),
(7, 2, 'like', '2024-01-02 10:00:00'),
(8, 2, 'comment', '2024-01-02 10:30:00'),
(9, 3, 'post', '2024-01-01 11:00:00'),
(10, 3, 'post', '2024-01-02 13:00:00'),
(11, 3, 'post', '2024-01-03 09:00:00'),
(12, 4, 'post', '2024-01-02 09:00:00'),
(13, 4, 'post', '2024-01-02 16:00:00'),
(14, 4, 'post', '2024-01-03 11:00:00'),
(15, 5, 'like', '2024-01-02 14:00:00'),
(16, 5, 'post', '2024-01-03 10:00:00'),
(17, 5, 'like', '2024-01-03 15:00:00');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

-- Write a query to get the percentage of users that have never liked or commented, rounded to two decimal places.

WITH users_count AS (
	SELECT 
		count(*) AS inactive_users,
		(SELECT count(*) FROM users) AS total_users
	FROM users u 
	WHERE u.user_id NOT IN (
		SELECT DISTINCT e.user_id
		FROM events e 
		WHERE e."action" IN ('like', 'comment')
	)
)
SELECT 
	ROUND(
		(uc.inactive_users * 100.0 / uc.total_users)
	, 2) AS inactive_users_percentage
FROM users_count uc;



