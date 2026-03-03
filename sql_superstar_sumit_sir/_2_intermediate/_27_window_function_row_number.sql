SELECT 
	e.employee_id,
	e.employee_name,
	e.department,
	e.salary,
	e.hire_date,
	ROW_NUMBER() OVER (PARTITION BY e.department ORDER BY e.salary) AS row_num 
FROM employees5 e;


SELECT 
	e.employee_id,
	e.employee_name,
	e.department,
	e.salary,
	e.hire_date,
	ROW_NUMBER() OVER (ORDER BY e.salary) AS row_num 
FROM employees5 e;


SELECT 
	e.employee_id,
	e.employee_name,
	e.department,
	e.salary,
	e.hire_date,
	e.city,
	ROW_NUMBER() OVER (
		PARTITION BY e.department, e.city 
		ORDER BY e.salary, e.hire_date
	) AS row_num 
FROM employees6 e;


SELECT 
	e.employee_id,
	e.employee_name,
	e.department,
	e.salary,
	e.hire_date,
	e.city,
	ROW_NUMBER() OVER (
		ORDER BY e.salary, e.hire_date
	) AS row_num 
FROM employees6 e;

-- 
SELECT 
	e.employee_id,
	e.employee_name,
	e.department,
	e.salary,
	e.hire_date,
	e.city,
	ROW_NUMBER() OVER (
		PARTITION BY e.department, e.city 
		ORDER BY e.salary, e.hire_date
	) AS row_num 
FROM employees6 e 
WHERE row_num <= 2;

 
SELECT * FROM (
	SELECT 
		e.employee_id,
		e.employee_name,
		e.department,
		e.salary,
		e.hire_date,
		e.city,
		ROW_NUMBER() OVER (
			PARTITION BY e.department, e.city 
			ORDER BY e.salary, e.hire_date
		) AS row_num 
	FROM employees6 e
) emp WHERE emp.row_num <= 2;


WITH emp AS (
	SELECT 
		e.employee_id,
		e.employee_name,
		e.department,
		e.salary,
		e.hire_date,
		e.city,
		ROW_NUMBER() OVER (
			PARTITION BY e.department, e.city 
			ORDER BY e.salary, e.hire_date
		) AS row_num 
	FROM employees6 e
)
SELECT * FROM emp 
WHERE emp.row_num <= 2;



