CREATE TABLE job_postings (
    id INT PRIMARY KEY,
    user_id INT,
    job_id INT,
    posted_date TIMESTAMP
);

INSERT INTO job_postings (id, user_id, job_id, posted_date) VALUES
(1, 1, 101, '2024-01-01'),
(2, 1, 102, '2024-01-02'),
(3, 2, 201, '2024-01-01'),
(4, 2, 201, '2024-01-15'),
(5, 2, 202, '2024-01-03'),
(6, 3, 301, '2024-01-01'),
(7, 4, 401, '2024-01-01'),
(8, 4, 401, '2024-01-15'),
(9, 4, 402, '2024-01-02'),
(10, 4, 402, '2024-01-16'),
(11, 5, 501, '2024-01-05'),
(12, 5, 502, '2024-01-10');

SELECT * FROM job_postings jp ;

-- Given a table of job postings, 
-- write a query to retrieve the number of users that have posted each job only once and 
-- the number of users that have posted at least one job multiple times.

WITH job_post_counts AS (
	SELECT job_id, count(*) as posting_count
	FROM job_postings
	GROUP BY job_id
)
SELECT 
	SUM(CASE WHEN jpc.posting_count = 1 THEN 1 ELSE 0 END) AS single_post_users,
	SUM(CASE WHEN jpc.posting_count > 1 THEN 1 ELSE 0 END) AS single_post_users
FROM job_post_counts jpc;
