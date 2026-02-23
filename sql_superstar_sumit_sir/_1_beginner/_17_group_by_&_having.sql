SELECT DISTINCT category 
FROM sales;

SELECT 
	category, 
	SUM(amount) AS total_sales
FROM sales
GROUP BY category;

SELECT 
	category, 
	MAX(sale_date) AS max_date, 
	SUM(amount) AS total_sales 
FROM sales 
GROUP BY category;


-- this is equivalent to distinct
SELECT category
FROM sales
GROUP BY category;

SELECT 
	category, 
	product, 
	SUM(amount) AS total_sales
FROM sales
GROUP BY category, product;


-- count of products in each category
SELECT 
	category, 
	COUNT(DISTINCT product) AS total_products
FROM sales
GROUP BY category;


-- total quantity sold for each product
SELECT 
	product,
	COUNT(*) AS total_orders,
	SUM(quantity) AS total_quantity
FROM sales
GROUP BY product;


-- 3 products with maximum sales volume
SELECT 
	product, 
	SUM(quantity) AS total_quantity 
FROM sales 
GROUP BY product 
ORDER BY total_quantity DESC 
LIMIT 3;


-- total sales and number of transactions per store location
SELECT 
	store_location,
	SUM(amount) AS total_sales,
	COUNT(*) AS num_transactions 
FROM sales 
GROUP BY store_location;


-- average sale amount by each customer
SELECT 
	customer_id,
	AVG(amount) AS average_sale 
FROM sales 
GROUP BY customer_id;


SELECT 
	customer_id, 
	AVG(amount) AS average_sale, 
	SUM(amount) AS total_purchase_amount, 
	COUNT(*) AS num_of_orders,
	SUM(amount)/count(*) AS avg_sale 
FROM sales 
GROUP BY customer_id;


-- Total sales by month and category
SELECT 
	DATE_FORMAT(sale_date,'%Y-%m') AS sale_month, 
	category, 
	SUM(amount) AS total_sales
FROM sales
GROUP BY sale_month, category 
ORDER BY sale_month;



SELECT 
	s.category, 
	MAX(s.amount) AS highest_sale
FROM sales AS s
GROUP BY s.category;

SELECT
	s.product,
	SUM(s.amount) AS total_sale,
	AVG(s.quantity) AS avg_quantity 
FROM sales AS s 
WHERE s.store_location = 'New York' 
GROUP BY s.product;

SELECT 
	s.product,
	SUM(s.amount) AS total_sale,
	SUM(s.quantity) AS sum_quantity 
FROM sales AS s 
WHERE s.store_location = 'New York' 
GROUP BY s.product 
HAVING s.product = 'Tablet';

SELECT 
	s.product,
	SUM(s.amount) AS total_sale,
	SUM(s.quantity) AS sum_quantity 
FROM sales AS s 
WHERE s.store_location = 'New York' AND s.product = 'Tablet'
GROUP BY s.product;

SELECT
	DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
	SUM(s.amount) AS total_sale,
	SUM(s.quantity) AS total_quantity 
FROM sales AS s 
GROUP BY sale_month 
ORDER BY sale_month;


SELECT
	s.store_location,
	COUNT(DISTINCT s.customer_id) AS customer_count 
FROM sales AS s
GROUP BY s.store_location;

SELECT 
	s.customer_id, 
	DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
	SUM(s.amount) AS montly_sale
FROM sales s 
GROUP BY s.customer_id, sale_month
ORDER BY s.customer_id;

SELECT 
	s.customer_id, 
	DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
	SUM(s.amount) AS montly_sale,
	COUNT(*) AS num_of_order_placed
FROM sales s 
GROUP BY s.customer_id, sale_month 
HAVING num_of_order_placed >= 8 
ORDER BY s.customer_id;


SELECT 
	s.customer_id, 
	DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
	AVG(s.amount) AS avg_montly_sale
FROM sales s 
GROUP BY s.customer_id, sale_month
HAVING avg_montly_sale > 600 
ORDER BY s.customer_id;


SELECT 
	s.category,
	SUM(s.amount) AS total_sales 
FROM sales s
WHERE MONTH(s.sale_date) = 1 
	AND YEAR(s.sale_date) = 2023 
GROUP BY s.category;


SELECT 
	s.customer_id AS premimum_cusomter_id,
	SUM(s.amount) AS total_sales 
FROM sales s
WHERE DAYOFWEEK(s.sale_date) BETWEEN 2 AND 6
GROUP BY s.customer_id 
HAVING total_sales > 7000 
ORDER BY total_sales DESC 
LIMIT 5;

SELECT
	s.store_location,
	SUM(amount) AS total_sales,
	COUNT(quantity) AS num_transactions 
FROM sales s
WHERE MONTH(s.sale_date) = 1 AND YEAR(s.sale_date) = 2023 
GROUP BY s.store_location
ORDER BY num_transactions;

SELECT
	s.store_location,
	SUM(amount) AS total_sales,
	COUNT(quantity) AS num_transactions 
FROM sales s
WHERE s.sale_date BETWEEN '2023-01-01' AND '2023-01-31' 
GROUP BY s.store_location
ORDER BY num_transactions;

