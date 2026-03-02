WITH aggregated_result AS (
	SELECT 
		order_item_order_id AS order_id, 
		COUNT(*) AS num_order_items, 
		SUM(order_item_subtotal) AS order_amount 
	FROM order_items 
	GROUP BY order_item_order_id
),
avg_order_result AS (
	SELECT 
		AVG(x.num_order_items) AS avg_order_items,
		AVG(x.order_amount) AS avg_order_amount 
	FROM aggregated_result x
)
SELECT * 
FROM aggregated_result a 
JOIN avg_order_result b 
ON (a.num_order_items > b.avg_order_items) 
AND (a.order_amount > b.avg_order_amount);



WITH aggregated_result AS (
	SELECT 
		order_item_order_id AS order_id, 
		COUNT(*) AS num_order_items, 
		SUM(order_item_subtotal) AS order_amount 
	FROM order_items 
	GROUP BY order_item_order_id
),
avg_order_items_result AS (
	SELECT 
		AVG(x.num_order_items) AS avg_order_items
	FROM aggregated_result x
),
avg_order_amount_result AS (
	SELECT 
		AVG(x.order_amount) AS avg_order_amount 
	FROM aggregated_result x
)
SELECT * 
FROM aggregated_result a 
WHERE a.num_order_items > (SELECT avg_order_items FROM avg_order_items_result) 
AND a.order_amount > (SELECT avg_order_amount FROM avg_order_amount_result);


WITH avg_dept_salary AS (
	SELECT 
		e.department_id AS dept_id, 
		AVG(e.salary) AS avg_dept_salary 
	FROM employees3 e 
	GROUP BY e.department_id
)
SELECT 
	e.*,
	d.avg_dept_salary  
FROM employees3 e 
JOIN avg_dept_salary d
ON e.department_id = d.dept_id 
AND e.salary > d.avg_dept_salary;



(SELECT 
	EmployeeID,
	EmployeeName,
	ManagerID,
	0 AS "Level"
FROM Employees4 e 
WHERE e.ManagerID IS NULL) 
UNION ALL
(SELECT 
	EmployeeID,
	EmployeeName,
	ManagerID,
	1 AS "Level"
FROM Employees4 e 
WHERE e.ManagerID = 1) 
UNION ALL
(SELECT 
	EmployeeID,
	EmployeeName,
	ManagerID,
	2 AS "Level"
FROM Employees4 e 
WHERE e.ManagerID IN (2, 3))


WITH RECURSIVE employee_hierarchy AS (
	-- anchor member: select the top level employee (CEO)
	SELECT 
		e.EmployeeID, 
		e.EmployeeName, 
		e.ManagerID, 
		0 AS "Level" 
	FROM Employees4 e 
	WHERE e.ManagerID IS NULL 
	UNION ALL
	-- recursive member: find employees who report to the current employee
	SELECT 
		e.EmployeeID, 
		e.EmployeeName, 
		e.ManagerID, 
		eh.level + 1 
	FROM Employees4 e 
	INNER JOIN employee_hierarchy eh 
	ON e.ManagerID = eh.EmployeeID
)
SELECT 
	EmployeeID, 
	EmployeeName, 
	ManagerID, 
	Level 
FROM employee_hierarchy 
ORDER BY Level, EmployeeID;




WITH RECURSIVE employee_hierarchy AS (
	-- anchor member: select the top level employee (CEO)
	SELECT 
		e.EmployeeID, 
		e.EmployeeName, 
		e.ManagerID  
	FROM Employees4 e 
	WHERE e.EmployeeID = 6 
	UNION ALL
	-- recursive member:
	SELECT 
		e.EmployeeID, 
		e.EmployeeName, 
		e.ManagerID  
	FROM Employees4 e 
	INNER JOIN employee_hierarchy eh 
	ON e.EmployeeID = eh.ManagerID  
)
SELECT 
	EmployeeID, 
	EmployeeName, 
	ManagerID 
FROM employee_hierarchy 
ORDER BY EmployeeID;




WITH RECURSIVE fibbonacci AS (
	-- anchor member
	SELECT 
		0 AS number, 
		1 AS next, 
		1 AS level
	UNION ALL
	-- recursive member
	SELECT 
		next,
		number + next,
		level + 1
	FROM fibbonacci f 
	WHERE f.level < 10
)
SELECT 
	number,
	level
FROM fibbonacci f;

