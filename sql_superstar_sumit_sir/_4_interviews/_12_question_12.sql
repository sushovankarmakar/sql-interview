CREATE TABLE Purchases1 (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO Purchases1 (purchase_id, customer_id, purchase_date, amount) VALUES
(1, 101, '2023-01-15', 12000.00),
(2, 101, '2023-02-10', 11000.00),
(3, 101, '2023-03-20', 10500.00),
(4, 101, '2023-04-10', 11500.00),
(5, 101, '2023-05-15', 13000.00),
(6, 101, '2023-06-25', 12500.00),
(7, 101, '2023-07-20', 14000.00),
(8, 101, '2023-08-05', 11000.00),
(9, 101, '2023-09-15', 15000.00),
(10, 101, '2023-10-10', 16000.00),
(11, 101, '2023-11-30', 17000.00),
(12, 101, '2023-12-20', 18000.00),
(13, 102, '2023-01-10', 5000.00),
(14, 102, '2023-02-15', 8000.00),
(15, 102, '2023-04-10', 6000.00),
(16, 102, '2023-05-20', 7000.00),
(17, 102, '2023-06-10', 8000.00),
(18, 102, '2023-08-15', 9000.00),
(19, 102, '2023-09-10', 6500.00),
(20, 102, '2023-10-30', 7000.00),
(21, 102, '2023-11-15', 10000.00),
(22, 103, '2023-01-25', 9500.00),
(23, 103, '2023-02-20', 9800.00),
(24, 103, '2023-03-10', 9900.00),
(25, 103, '2023-04-25', 9200.00),
(26, 103, '2023-05-10', 10500.00),
(27, 103, '2023-06-05', 11000.00),
(28, 103, '2023-07-15', 11500.00),
(29, 103, '2023-08-25', 10000.00),
(30, 103, '2023-09-20', 9800.00),
(31, 103, '2023-10-05', 10500.00),
(32, 103, '2023-11-10', 12000.00),
(33, 103, '2023-12-30', 14000.00),
(34, 104, '2023-01-05', 12000.00),
(35, 104, '2023-02-01', 14000.00),
(36, 104, '2023-03-12', 13000.00),
(37, 104, '2023-05-15', 10000.00),
(38, 104, '2023-07-10', 8000.00),
(39, 104, '2023-08-25', 11000.00),
(40, 104, '2023-09-20', 12000.00),
(41, 104, '2023-11-05', 10500.00);

SELECT * FROM Purchases1 p;

-- 13.1: Write a query to find customer_id and total_spent for customers
-- who spent more than $10,000 every month in the last year.

SELECT 
	p.customer_id, 
	SUM(p.amount) AS total_spent   
FROM Purchases1 p 
WHERE p.amount > 10000 
GROUP BY p.customer_id, YEAR(p.purchase_date) 
HAVING COUNT(YEAR(p.purchase_date)) = 12; 


-- 13.2:Write an SQL query to find the customer_id and the missing_month for each customer 
-- who did not make a purchase in at least one month during 2023. 
-- The missing_month should be formatted as 'YYYY-MM'.

WITH months_reference AS ( 
	SELECT '2023-01' AS months 
	UNION ALL 
	SELECT '2023-02' AS months
	UNION ALL 
	SELECT '2023-03' AS months 
	UNION ALL 
	SELECT '2023-04' AS months
	UNION ALL 
	SELECT '2023-05' AS months 
	UNION ALL 
	SELECT '2023-06' AS months
	UNION ALL 
	SELECT '2023-07' AS months 
	UNION ALL 
	SELECT '2023-08' AS months
	UNION ALL 
	SELECT '2023-09' AS months 
	UNION ALL 
	SELECT '2023-10' AS months
	UNION ALL 
	SELECT '2023-11' AS months 
	UNION ALL 
	SELECT '2023-12' AS months
), 
distinct_customers AS (
	SELECT DISTINCT p.customer_id  
	FROM Purchases1 AS p 
),  
customer_month_combo AS (
	SELECT customer_id, months  
	FROM distinct_customers 
	CROSS JOIN months_reference 
)
SELECT * 
FROM Purchases1 p 
JOIN customer_month_combo c
ON p.customer_id = c.customer_id 
AND DATE_FORMAT(p.purchase_date, '%Y-%m') != c.months; 

WITH month_numbers AS (
	SELECT 1 AS n 
	UNION ALL SELECT 2 
	UNION ALL SELECT 3 
	UNION ALL SELECT 4
	UNION ALL SELECT 5 
	UNION ALL SELECT 6 
	UNION ALL SELECT 7 
	UNION ALL SELECT 8
	UNION ALL SELECT 9 
	UNION ALL SELECT 10 
	UNION ALL SELECT 11 
	UNION ALL SELECT 12
), 
distinct_customers AS (
	SELECT DISTINCT p.customer_id
	FROM purchases1 p
),
customer_all_months AS (
	SELECT DISTINCT
		c.customer_id,
		DATE_FORMAT(DATE_SUB('2023-12-01', INTERVAL (n.n - 1) MONTH), '%Y-%m') AS all_months
	FROM month_numbers n
	CROSS JOIN distinct_customers c
)
SELECT 
	cm.customer_id,
	cm.all_months AS missing_month 
FROM customer_all_months cm 
LEFT JOIN purchases1 AS p 
ON cm.customer_id = p.customer_id 
AND cm.all_months = DATE_FORMAT(p.purchase_date, '%Y-%m') 
WHERE p.customer_id IS NULL 
ORDER BY cm.customer_id, missing_month; 





