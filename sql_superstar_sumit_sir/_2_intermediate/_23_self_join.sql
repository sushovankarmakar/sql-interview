SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM departments;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM products;


SELECT 
	e.employee_name AS emp_name,
	e.salary AS emp_salary,
	m.employee_name AS manager_name,
	m.salary AS manager_salary  
FROM employees1 e 
LEFT JOIN employees1 m 
ON e.manager_id = m.employee_id;


SELECT e1.employee_id 
FROM employees1 e1 
WHERE e1.manager_id IS NULL;


SELECT 
	e.employee_name AS emp_name,
	e.salary AS emp_salary,
	m.employee_name AS manager_name,
	m.salary AS manager_salary  
FROM employees1 e 
RIGHT JOIN employees1 m 
ON e.manager_id = m.employee_id 
WHERE e1.employee_id IS NULL;


SELECT 
	e.employee_name AS emp_name,
	e.salary AS emp_salary,
	m.employee_name AS manager_name,
	m.salary AS manager_salary  
FROM employees1 e 
INNER JOIN employees1 m 
ON e.manager_id = m.employee_id 
WHERE emp_salary > manager_salary;


SELECT 
	e.employee_id AS emp_id,
	e.salary,
	e.department_id AS dept_id,
	d.avg_salary 
FROM employees1 e 
INNER JOIN (
	SELECT 
		e1.department_id AS dept_id, 
		ROUND(AVG(e1.salary), 2) AS avg_salary
	FROM employees1 e1 
	GROUP BY e1.department_id
) d
ON e.department_id = d.dept_id 
WHERE e.salary > d.avg_salary;


SELECT * FROM courses1 c;

-- courses that take longer to complete than their prerequisite
SELECT 
	c.course_id,
	c.course_name,
	c.duration_weeks, 
	p.course_id AS pre_course_id,
	p.course_name AS pre_course_name,
	p.duration_weeks AS pre_duration_weeks 
FROM courses1 c
INNER JOIN courses1 p
ON c.prerequisite_id = p.course_id  
WHERE c.duration_weeks > p.duration_weeks;


SELECT 
	c.customer_id,
	c.customer_fname,
	c.customer_lname,
	c.customer_city,
	c.customer_state,
	c.customer_zipcode,
	o.order_id,
	o.order_date,
	o.order_status,
	oi.order_item_id,
	oi.order_item_quantity,
	oi.order_item_subtotal,
	oi.order_item_product_price,
	p.product_id,
	p.product_name,
	p.product_price,
	cat.category_id,
	cat.category_name,
	d.department_id,
	d.department_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.order_customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_item_order_id
INNER JOIN products p
ON oi.order_item_product_id = p.product_id
INNER JOIN categories cat
ON p.product_category_id = cat.category_id
INNER JOIN departments d
ON cat.category_department_id = d.department_id;


SELECT * FROM order_items AS oi; 



SELECT 
	order_item_order_id AS order_id, 
	COUNT(*) AS num_order_items, 
	SUM(order_item_subtotal) AS order_amount 
FROM order_items 
GROUP BY order_item_order_id;


SELECT 
	AVG(x.num_order_items) AS avg_order_items,
	AVG(x.order_amount) AS avg_order_amount
FROM (
	SELECT 
		order_item_order_id AS order_id,
		COUNT(*) AS num_order_items, 
		SUM(order_item_subtotal) as order_amount 
	FROM order_items 
	GROUP BY order_item_order_id
) x;

SELECT * FROM order_items;
SELECT * FROM orders;

-- Find avg number of orders placed by each customer

SELECT
	AVG(x.total_orders) AS avg_orders 
FROM
(SELECT
	o.order_customer_id,
	COUNT(*) AS total_orders
FROM orders o 
GROUP BY o.order_customer_id) x;



SELECT * 
FROM (
    SELECT 
      order_item_order_id AS order_id, 
      COUNT(*) AS num_order_items, 
      SUM(order_item_subtotal) AS order_amount 
    FROM order_items 
    GROUP BY order_item_order_id
) a 
JOIN (
  SELECT 
    AVG(num_order_items) AS avg_order_items, 
    AVG(order_amount) AS avg_order_amount 
  FROM (
      SELECT 
        order_item_order_id AS order_id, 
        COUNT(*) AS num_order_items, 
        SUM(order_item_subtotal) AS order_amount 
      FROM order_items 
      GROUP BY order_item_order_id
    ) x
) b 
ON (num_order_items > avg_order_items)  
AND (order_amount > avg_order_amount);


SELECT 
  order_item_order_id AS order_id, 
  COUNT(*) AS num_order_items, 
  SUM(order_item_subtotal) AS order_amount 
FROM order_items 
GROUP BY order_item_order_id;


SELECT 
	order_customer_id, 
	COUNT(*) AS num_of_orders 
FROM orders 
GROUP BY order_customer_id 
HAVING COUNT(*) > (5.5528);

SELECT 
	order_customer_id, 
	COUNT(*) AS num_of_orders 
FROM orders 
GROUP BY order_customer_id 
HAVING COUNT(*) > (
	SELECT
		AVG(x.total_orders) AS avg_orders 
	FROM
	(SELECT
		o.order_customer_id,
		COUNT(*) AS total_orders
	FROM orders o 
	GROUP BY o.order_customer_id) x
);


-- as part of select in orders table I want one extra column which indicates
-- the avg number of orders each customer places.

SELECT 
	*, 
	(
		SELECT
			AVG(x.total_orders) AS avg_orders 
		FROM
			(SELECT
				o.order_customer_id,
				COUNT(*) AS total_orders
			FROM orders o 
			GROUP BY o.order_customer_id) x
	) AS avg_orders 
FROM orders;


SELECT * 
FROM employees2 e1 
WHERE e1.salary > (
	SELECT
		AVG(e.salary) AS avg_salary
	FROM employees2 e
);


SELECT 
	e.*,
	d.avg_dept_salary  
FROM employees3 e 
JOIN
	(SELECT 
		e.department_id AS dept_id, 
		AVG(e.salary) AS avg_dept_salary 
	FROM employees3 e 
	GROUP BY e.department_id) d
ON e.department_id = d.dept_id 
AND e.salary > d.avg_dept_salary; 


SELECT *
FROM employees3 e1 
WHERE e1.salary > (
	SELECT  
		AVG(e.salary) AS avg_dept_salary 
	FROM employees3 e 
	WHERE e1.department_id = e.department_id 
);




