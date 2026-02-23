SELECT 
	COUNT(*) AS total_orders, 
	SUM(amount) AS total_sales, 
	MAX(amount) AS max_order_amount, 
	MIN(amount) AS min_order_amount, 
	AVG(amount) AS avg_order_value 
FROM sales;


SELECT 'total_orders' AS aggregation, COUNT(*) AS value FROM sales 
UNION 
SELECT 'total_sales', SUM(amount) AS total_sales FROM sales 
UNION 
SELECT 'max_order_amount', MAX(amount) AS max_order_amount FROM sales 
UNION 
SELECT 'min_order_amount', MIN(amount) AS min_order_amount FROM sales 
UNION 
SELECT 'avg_order_value', AVG(amount) AS avg_order_value FROM sales;


SELECT 'total_orders' AS aggregation, count(*) AS value FROM sales
UNION ALL
SELECT 'total_sales', SUM(amount) AS total_sales FROM sales
UNION ALL
SELECT 'max_order_amount', MAX(amount) AS max_order_amount FROM sales
UNION ALL
SELECT 'min_order_amount', MIN(amount) AS min_order_amount FROM sales
UNION ALL
SELECT 'avg_order_value', AVG(amount) AS avg_order_value FROM sales
UNION ALL
SELECT 'total_sales', SUM(amount) AS total_sales FROM sales;


SELECT 
	COUNT(*) AS total_orders, 
	SUM(amount) AS total_sales, 
	MAX(amount) AS max_order_amount, 
	MIN(amount) AS min_order_amount, 
	AVG(amount) AS avg_order_value, 
	MIN(sale_date) AS min_sale_date, 
	MAX(sale_date) AS max_sale_date 
FROM sales;


