SELECT current_date(); -- 2026-02-24
SELECT current_time(); -- 00:30:38
SELECT current_timestamp(); -- 2026-02-24 00:30:46

SELECT DATE('2024-07-26 04:32:05') AS date_only; -- 2024-07-26
SELECT TIME('2024-07-26 04:32:05') AS date_only; -- 04:32:05

SELECT EXTRACT(YEAR FROM '2024-07-26') AS year_only; -- 2024
SELECT EXTRACT(WEEK FROM '2024-07-26') AS year_only; -- 29
SELECT EXTRACT(MONTH FROM'2024-07-26') AS month_only; -- 7
SELECT EXTRACT(DAY FROM '2024-07-26') AS day_only; -- 26


SELECT 
	EXTRACT(YEAR FROM sale_date) AS year, 
	SUM(amount) AS total_sales 
FROM sales 
GROUP BY year;

SELECT 
	EXTRACT(MONTH FROM sale_date) AS month, 
	SUM(amount) AS total_sales 
FROM sales 
GROUP BY month;


SELECT 
	CONCAT(EXTRACT(YEAR FROM sale_date), '-', EXTRACT(MONTH FROM sale_date)) AS yearmonth, 
	SUM(amount) AS total_sales 
FROM sales 
GROUP BY yearmonth;

SELECT 
	EXTRACT(YEAR_MONTH FROM sale_date) AS yearmonth, 
	SUM(amount) AS total_sales 
FROM sales
GROUP BY yearmonth;

SELECT DAYNAME('2026-02-24') AS day_name; -- Tuesday
SELECT MONTHNAME('2026-02-24') AS month_name; -- February


SELECT DATE_ADD(CURRENT_DATE, INTERVAL 10 day) AS newdate; -- 2026-03-06 
SELECT DATE_SUB(CURRENT_DATE, INTERVAL 43 DAY) AS newdate; -- 2026-01-12

SELECT DATEDIFF(CURRENT_DATE, '2024-06-13'); -- 621
SELECT DATEDIFF(CURRENT_DATE, '1992-02-13'); -- 12,430
SELECT DATEDIFF('2026-02-24', '2026-06-23'); -- -119
SELECT DATEDIFF('2024-08-05', '2024-06-13'); -- 53


SELECT DATE_FORMAT('2017-06-15','%y'); -- 17
SELECT DATE_FORMAT('2017-06-15','%Y'); -- 2017
SELECT DATE_FORMAT('2017-06-15','%m'); -- 06
SELECT DATE_FORMAT('2017-06-15','%M'); -- June
SELECT DATE_FORMAT('2017-06-15','%d'); -- 15
SELECT DATE_FORMAT('2017-06-15','%D'); -- 15th
SELECT DATE_FORMAT('2017-06-15','%M %D %Y'); -- June 15th 2017 
SELECT DATE_FORMAT('2017-06-15','%m %d %y'); -- 06 15 17
SELECT DATE_FORMAT('2017-06-15','%d-%M-%Y'); -- 15-June-2017


SELECT UNIX_TIMESTAMP(); -- 1771909894
SELECT FROM_UNIXTIME(1771909894); -- 2026-02-24 10:41:34
SELECT UNIX_TIMESTAMP('2024-06-23'); -- 1719081000


SELECT ABS(-10); -- 10

SELECT CEIL(5.1); -- 6
SELECT CEIL(-5.1); -- -5

SELECT FLOOR(5.9); -- 5
SELECT FLOOR(-5.9); -- -6

SELECT ROUND(4.567, 2); -- 4.57
SELECT TRUNCATE(4.567, 2); -- 4.56
SELECT MOD(10,3); -- 1
SELECT POWER(2,3); -- 8
SELECT SQRT(16); -- 4

SELECT SIGN(5); -- 1
SELECT SIGN(0); -- 0
SELECT SIGN(-5); -- -1

SELECT RAND(); -- 0.75


SELECT *,
	CASE
		WHEN salary < 45000 THEN 'low' 
		WHEN salary BETWEEN 45000 AND 55000 THEN 'medium' 
		ELSE 'high'
	END AS salary_band 
FROM employees;


SELECT *,
	CASE
		WHEN years_of_exp < 3 THEN 'low experience'
		WHEN years_of_exp < 8 THEN 'medium experience'
		WHEN years_of_exp < 15 THEN 'high experience'
		ELSE 'cant say'
	END as experience_band 
FROM students;



SELECT YEAR(CAST(hire_date AS DATE)) 
FROM employees101;

SELECT cast(salary AS DECIMAL(10,2)) * 1.1 
FROM employees101;


SELECT 
	product_name,
	COALESCE(discount_price, regular_price) AS display_price 
FROM products;

SELECT 
	order_id, 
	COALESCE(billing_address, shipping_address, customer_address) AS preferred_address 
FROM orders;

SELECT 
	sale_id, 
	online_sales + store_sales AS total_sales 
FROM sales_new;

SELECT 
	sale_id, 
	COALESCE(online_sales, 0) + COALESCE(store_sales, 0) AS total_sales 
FROM sales_new;

