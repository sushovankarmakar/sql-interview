-- find max salary for each department
SELECT
	e.department, 
	MAX(e.salary) AS max_salary_dept 
FROM employees5 e 
GROUP BY e.department 
ORDER BY max_salary_dept DESC;


-- find max salary for each department
WITH max_salary_result AS (
	SELECT 
		e.department, 
		MAX(e.salary) AS max_salary_dept 
	FROM employees5 e 
	GROUP BY e.department
)
SELECT 
	e1.employee_id, 
	e1.employee_name, 
	s.department, 
	s.max_salary_dept 
FROM employees5 e1 
JOIN max_salary_result s 
ON e1.department = s.department 
AND e1.salary = s.max_salary_dept 
ORDER BY e1.salary DESC;



