SELECT 
	o.order_id, 
	DATE(o.order_date), 
	o.order_status, 
	c.customer_id, 
	c.customer_fname, 
	c.customer_city, 
	c.customer_state
FROM customers c
LEFT JOIN orders o
ON o.order_customer_id = c.customer_id;


SELECT 
	COUNT(c.customer_id) AS cnt  
FROM customers c
LEFT OUTER JOIN orders o
ON o.order_customer_id = c.customer_id 
WHERE o.order_id IS NULL;

SELECT * FROM customers AS c;
SELECT * FROM orders AS o;

SELECT 
	c.customer_state,
	count(o.order_id) AS order_count 
FROM customers c 
INNER JOIN orders o 
ON c.customer_id = o.order_customer_id 
GROUP BY c.customer_state 
ORDER BY order_count DESC 
LIMIT 3;


SELECT 
	c.customer_id, 
	c.customer_fname, 
	COUNT(o.order_id) AS num_orders 
FROM customers c 
INNER JOIN orders o 
ON c.customer_id = o.order_customer_id 
WHERE o.order_status = 'CLOSED' 
GROUP BY c.customer_id
ORDER BY num_orders DESC 
LIMIT 5;

SELECT 
	o.order_customer_id, 
	COUNT(o.order_id) AS num_orders 
FROM orders o  
WHERE o.order_status = 'CLOSED' 
GROUP BY o.order_customer_id
ORDER BY num_orders DESC 
LIMIT 5;

SELECT 
	c.customer_street, 
	COUNT(DISTINCT o.order_status) AS order_status_count 
FROM customers c 
INNER JOIN orders o 
ON c.customer_id = o.order_customer_id 
GROUP BY c.customer_street 
HAVING order_status_count = 9;

SELECT 
	c.customer_street,
	COUNT(DISTINCT o.order_status) AS order_status_count
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.order_customer_id 
GROUP BY c.customer_street 
HAVING order_status_count = (SELECT COUNT(DISTINCT o.order_status) FROM orders o);




