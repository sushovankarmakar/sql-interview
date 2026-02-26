USE retail_db;

SELECT COUNT(*) FROM categories; -- 58
SELECT COUNT(*) FROM customers; -- 12,435
SELECT COUNT(*) FROM departments; -- 6
SELECT COUNT(*) FROM order_items; -- 172,198
SELECT COUNT(*) FROM orders; -- 68,883
SELECT COUNT(*) FROM products; -- 1345



SELECT 
	o.*, 
	c.* 
FROM orders o 
JOIN customers c 
ON o.order_customer_id = c.customer_id;

SELECT 
	o.order_id, 
	DATE(o.order_date), 
	o.order_customer_id, 
	o.order_status, 
	c.customer_fname, 
	c.customer_city, 
	c.customer_state 
FROM orders o 
JOIN customers c 
ON o.order_customer_id = c.customer_id;

-- customers who have placed at least 1 orders
SELECT COUNT(DISTINCT c.customer_id) 
FROM orders o 
INNER JOIN customers c 
ON o.order_customer_id = c.customer_id;

SELECT COUNT(*) FROM (
	SELECT 
		o.order_customer_id,
		COUNT(o.order_customer_id) AS cnt 
	FROM orders o 
	INNER JOIN customers c 
	ON o.order_customer_id = c.customer_id 
	GROUP BY o.order_customer_id 
	HAVING cnt >= 5
) c; -- 8064


SELECT COUNT(*) FROM (
	SELECT customer_id FROM customers 
	INTERSECT 
	SELECT order_customer_id FROM orders
) AS c;

SELECT COUNT(*) FROM (
	SELECT customer_id FROM customers c 
	EXCEPT 
	SELECT order_customer_id FROM orders o
) AS c;


SELECT COUNT(customer_id) AS cnt 
FROM customers c 
WHERE c.customer_id NOT IN (
	SELECT order_customer_id FROM orders o
);

SELECT COUNT(customer_id) AS cnt
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o
    WHERE o.order_customer_id = c.customer_id
);

