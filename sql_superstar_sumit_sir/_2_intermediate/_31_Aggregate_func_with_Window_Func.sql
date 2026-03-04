
SELECT * FROM employees6 e;

-- rank based on highest to lowest salary in each department
SELECT 
	e.employee_id, 
	e.department, 
	e.salary, 
	ROW_NUMBER() OVER (PARTITION BY e.department ORDER BY e.salary DESC) AS row_num 
FROM employees6 e; 

-- Total salary paid for each department
SELECT 
	e.department, 
	SUM(e.salary) AS total_salary 
FROM employees6 AS e 
GROUP BY e.department;


-- Total salary paid for each department
WITH total_salary_paid AS (
	SELECT 
		e.department, 
		SUM(e.salary) AS total_salary 
	FROM employees6 AS e 
	GROUP BY e.department
)
SELECT 
	e.*,
	t.total_salary 
FROM employees6 AS e 
JOIN total_salary_paid AS t 
ON e.department = t.department;

SELECT 
	e.*,
	SUM(e.salary) OVER (PARTITION BY e.department) AS total_salary_per_dept
FROM employees6 AS e;

SELECT 
	e.*,
	SUM(e.salary) OVER (PARTITION BY e.city) AS total_salary_per_city 
FROM employees6 AS e;

SELECT 
	e.*,
	SUM(e.salary) OVER (PARTITION BY e.department, e.city) AS total_salary_per_dept_per_city 
FROM employees6 AS e;

-- Percentage of salary each employee earns within each department in each city
WITH per_dept_per_city AS (
	SELECT 
		e.*,
		SUM(e.salary) OVER (PARTITION BY e.department, e.city) AS total_salary_per_dept_per_city 
	FROM employees6 AS e
)
SELECT 
	x.employee_id,
	x.salary, 
	x.total_salary_per_dept_per_city, 
	ROUND(((x.salary / x.total_salary_per_dept_per_city) * 100), 2) AS pct_salary  
FROM per_dept_per_city x;


SELECT 
	e.*,
	SUM(e.salary) OVER (PARTITION BY e.department) AS total_salary,
	MAX(e.salary) OVER (PARTITION BY e.department) AS max_salary,
	MIN(e.salary) OVER (PARTITION BY e.department) AS min_salary,
	AVG(e.salary) OVER (PARTITION BY e.department) AS avg_salary,
	COUNT(e.salary) OVER (PARTITION BY e.department) AS count_salary 
FROM employees6 AS e;

-- Employee earning more than avg salary of their department
WITH avg_salary_result AS (
	SELECT 
		e.*, 
		AVG(e.salary) OVER (PARTITION BY e.department) AS avg_salary 
	FROM employees6 AS e
)
SELECT 
	x.employee_id,
	x.department, 
	x.salary, 
	x.avg_salary 
FROM avg_salary_result x 
WHERE x.salary > x.avg_salary;

-- Running Total salary paid for each department
SELECT
	e.employee_id,  
	e.department, 
	e.hire_date, 
	SUM(e.salary) OVER (PARTITION BY e.department ORDER BY e.hire_date) AS running_total 
FROM employees6 AS e;

-- Total salary for each city
SELECT 
	e.city, 
	SUM(e.salary) AS total_salary 
FROM employees6 AS e 
GROUP BY e.city;


-- Running Total salary paid for each department
SELECT
	e.employee_id,  
	e.city, 
	SUM(e.salary) OVER (PARTITION BY e.city ORDER BY e.hire_date) AS running_total 
FROM employees6 AS e;


-- Total salary for each department in each city
SELECT 
	e.department, 
	e.city, 
	SUM(e.salary) AS total_salary 
FROM employees6 AS e 
GROUP BY e.department, e.city;


-- Running Total salary paid for each department, in each city
SELECT
	e.employee_id, 
	e.department, 
	e.city, 
	SUM(e.salary) OVER (PARTITION BY e.department, e.city ORDER BY e.hire_date) AS running_total 
FROM employees6 AS e;




