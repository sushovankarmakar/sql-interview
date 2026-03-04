SELECT 
	e.employee_id, 
	e.hire_date, 
	ROW_NUMBER() OVER (ORDER BY e.hire_date) AS row_num, 
	RANK() OVER (ORDER BY e.hire_date) AS rnk, 
	DENSE_RANK() OVER (ORDER BY e.hire_date) AS dense_rnk
FROM employees e;

SELECT 
	e.employee_id, 
	e.salary,
	ROW_NUMBER() OVER (ORDER BY e.salary DESC) AS row_num,
	RANK() OVER (ORDER BY e.salary DESC) AS rnk,
	DENSE_RANK() OVER (ORDER BY e.salary DESC) AS dense_rnk
FROM employees e;