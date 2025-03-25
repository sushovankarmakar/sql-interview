CREATE TABLE transactions (
	id INT PRIMARY KEY,
	user_id INT,
	created_at TIMESTAMP,
	shipping_address VARCHAR(255)
);

-- Transactions sample data
INSERT INTO transactions (id, user_id, created_at, shipping_address) VALUES
(1, 1, '2025-01-15 10:30:00', '123 Main St'), 
(2, 1, '2025-01-16 11:45:00', '789 Oak Ave'), 
(3, 2, '2025-01-17 14:20:00', '456 Elm St'), 
(4, 2, '2025-01-18 15:10:00', '123 Pine Rd'), 
(5, 3, '2025-01-19 16:05:00', '789 Oak Ave'), 
(6, 3, '2025-01-20 17:40:00', '123 Main St'),
(7, 3, '2025-01-21 17:45:00', '123 Main St');

CREATE TABLE users1 (
	id INT PRIMARY KEY,
	name VARCHAR(255),
	address VARCHAR(255)
);

-- Users sample data
INSERT INTO users1 (id, name, address) VALUES
(1, 'John Doe', '123 Main St'),
(2, 'Jane Smith', '456 Elm St'),
(3, 'Alice Johnson', '789 Oak Ave');


SELECT * FROM transactions t ;
SELECT * FROM users1 u;


-- Given a table of transactions and a table of users, write a query to determine if users tend to order more to their primary address versus other addresses.
-- Note: Return the percentage of transactions ordered to their home address as home_address_percent.


WITH orders AS (
    SELECT 
        SUM(
        	CASE
            	WHEN t.shipping_address = u.address THEN 1
            	ELSE NULL
        	END
        ) AS home_address_orders,
        COUNT(t.id) AS total_orders
    FROM transactions t 
    JOIN users1 u ON t.user_id = u.id
) 
SELECT 
    (o.home_address_orders * 100.0 / total_orders) AS home_address_percent
FROM orders o;

-- optimized version: performance improvements for the above query

-- Performance Improvements
-- Use of FILTER Clause : More efficient as it's specifically designed for conditional counting
-- NULL Handling : Added NULLIF to prevent division by zero

WITH address_match_counts AS (
	SELECT
	    COUNT(*) FILTER (WHERE t.shipping_address = u.address) AS home_address_orders,
	    COUNT(*) AS total_orders
	FROM transactions t
	JOIN users1 u ON t.user_id = u.id
)
SELECT 
	ROUND(
		(amc.home_address_orders * 100.0 / NULLIF(amc.total_orders, 0))
	, 2) AS home_address_percent
FROM address_match_counts amc;

