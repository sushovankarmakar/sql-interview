CREATE TABLE customer_sales (
    id INT PRIMARY KEY,
    transaction_value DECIMAL(10, 2),
    created_at TIMESTAMP
);

INSERT INTO customer_sales (id, transaction_value, created_at)
VALUES
(1, 50.00, '2025-01-23 10:15:00'),
(2, 30.00, '2025-01-23 15:45:00'),
(3, 20.00, '2025-01-23 18:30:00'),
(4, 45.00, '2025-01-24 09:20:00'),
(5, 60.00, '2025-01-24 22:10:00'),
(6, 25.00, '2025-01-25 11:30:00'),
(7, 35.00, '2025-01-25 14:50:00'),
(8, 55.00, '2025-01-25 19:05:00');

SELECT * FROM customer_sales cs ;

-- Given a table of customer sales in a retail store 
-- with columns id, transaction_value, and created_at representing the date and time for each transaction, 
-- write a query to get the last transaction for each day.
-- The output should include the ID of the transaction, datetime of the transaction, and the transaction amount. 
-- Order the transactions by datetime.

-- my initial solution
WITH transaction_details AS (
	SELECT cs.*, 
		MAX(cs.id) OVER(PARTITION BY DATE(cs.created_at)) AS latest_id
	FROM customer_sales cs
)
SELECT 
	td.id,
	td.created_at,
	td.transaction_value
FROM transaction_details td
WHERE td.id = td.latest_id;

-- better efficient solution
-- Used ROW_NUMBER() instead of MAX() window function
-- More efficient for finding last record per group
-- Considers actual timestamp, not just ID
WITH latest_transactions AS (
	SELECT 
		cs.id,
		cs.transaction_value,
		cs.created_at,
		row_number() OVER (
			PARTITION BY DATE(cs.created_at)
			ORDER BY created_at DESC
		) AS rn
	FROM customer_sales cs 
)
SELECT 
	lt.id,
	lt.created_at,
	lt.transaction_value
FROM latest_transactions lt
WHERE lt.rn = 1
ORDER BY lt.created_at;





