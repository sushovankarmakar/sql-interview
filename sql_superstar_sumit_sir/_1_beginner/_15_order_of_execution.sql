SELECT source_of_joining 
FROM students 
WHERE location IN ('BANGALORE','HYDERABAD','PUNE') 
ORDER BY years_of_exp DESC 
LIMIT 5;


SELECT 
	first_name 
FROM employees 
WHERE job_title != 'Manager' 
ORDER BY salary DESC 
LIMIT 5;