CREATE TABLE Users_13 (
	user_id INT,
	email VARCHAR(255)
);

INSERT INTO Users_13 (user_id, email) VALUES
(1, 'alice@example.com'),
(2, 'bob@example.net'),
(2, 'bob@differentdomain.com'),
(3, 'charlie@example.com'),
(4, 'dave@anotherdomain.com'),
(5, 'eve@example.com'),
(6, 'frank@example.org'),
(7, 'grace@anotherdomain.com'),
(8, 'heidi@anotherdomain.com'),
(9, 'ivan@example.com'),
(10, 'judy@example.net'),
(11, 'lisa@example.com'),
(11, 'lisa@randomdomain.com'),
(12, 'mike@example.net'),
(13, 'nina@randomdomain.com'),
(14, 'oliver@anotherdomain.com'),
(15, 'paul@example.com');


-- Count the number of unique domains
SELECT 
	COUNT(DISTINCT SUBSTRING(
		u.email, 
		LOCATE('@', u.email) + 1, 
		LENGTH(Email)
	)) AS distinct_domain_count  
FROM Users_13 u;


-- Find the top 3 most common domains
WITH all_domains AS (
	SELECT 
		SUBSTRING(
			u.email, 
			LOCATE('@', u.email) + 1, 
			LENGTH(Email)
		) AS domains 
	FROM Users_13 u
)
SELECT 
	d.domains, 
	COUNT(d.domains) AS domain_count 
FROM all_domains d
GROUP BY d.domains 
ORDER BY domain_count DESC 
LIMIT 3; 



-- Users who are using multiple email addresses with different domains
WITH all_domains AS (
	SELECT 
		u.user_id, 
		SUBSTRING(
			u.email, 
			LOCATE('@', u.email) + 1, 
			LENGTH(Email)
		) AS domains 
	FROM Users_13 u
)
SELECT 
	d.user_id, 
	COUNT(DISTINCT d.domains) AS domain_counts 
FROM all_domains d 
GROUP BY d.user_id 
HAVING domain_counts > 1;



-- Users who are using multiple email addresses with different domains - GROUP_CONCAT
WITH all_domains AS (
	SELECT 
		u.user_id, 
		SUBSTRING(
			u.email, 
			LOCATE('@', u.email) + 1, 
			LENGTH(Email)
		) AS domains 
	FROM Users_13 u
)
SELECT 
	d.user_id, 
	GROUP_CONCAT(DISTINCT d.domains SEPARATOR ', ') AS different_domains 
FROM all_domains d 
GROUP BY d.user_id 
HAVING COUNT(DISTINCT d.domains) > 1;


