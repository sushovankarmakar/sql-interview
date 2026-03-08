CREATE TABLE EMPLOYEES11 (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department_ID INT
);

CREATE TABLE SALARIES11 (
    Employee_ID INT,
    Salary DECIMAL(10, 2),
    PRIMARY KEY (Employee_ID)
);

CREATE TABLE DEPARTMENTS11 (
    Department_ID INT PRIMARY KEY,
    Min_Salary DECIMAL(10, 2),
    Max_Salary DECIMAL(10, 2)
);

-- Insert data into EMPLOYEES table
INSERT INTO EMPLOYEES11 (Employee_ID, Name, Department_ID) VALUES
(1, 'John', 10),
(2, 'Jane', 20),
(3, 'Jim', 10),
(4, 'Jack', 30),
(6, 'Jill', 20);

-- Insert data into SALARIES table
INSERT INTO SALARIES11 (Employee_ID, Salary) VALUES
(1, 50000),
(2, 60000),
(4, 20000),
(5, 70000),
(6, 100000);

-- Insert data into DEPARTMENTS table
INSERT INTO DEPARTMENTS11 (Department_ID, Min_Salary, Max_Salary)
VALUES
(10, 45000, 90000),
(20, 55000, 95000),
(30, 25000, 80000);

-- Detect employees who are in the EMPLOYEES table but not in the SALARIES table and label them as "Missing Salary".
SELECT 
	e.employee_id, "Missing Salary" AS Comment 
FROM EMPLOYEES11 e 
LEFT JOIN SALARIES11 s 
ON e.employee_id = s.employee_id 
WHERE s.employee_id IS NULL;

-- Detect employees who are in the SALARIES table but not in the EMPLOYEES table and label them as "Missing Employee".
SELECT 
	s.employee_id, "Missing Employee" AS Comment 
FROM SALARIES11 s 
LEFT JOIN EMPLOYEES11 e 
ON s.employee_id = e.employee_id 
WHERE e.employee_id IS NULL;


SELECT 
	e.employee_id, 
	d.department_id, 
	d.min_salary, 
	d.max_salary  
FROM EMPLOYEES11 e 
JOIN DEPARTMENTS11 d 
ON e.department_id = d.department_id;

WITH min_max_sal AS (
	SELECT 
		e.employee_id, 
		d.department_id, 
		d.min_salary, 
		d.max_salary  
	FROM EMPLOYEES11 e 
	JOIN DEPARTMENTS11 d 
	ON e.department_id = d.department_id
)
SELECT 
	m.employee_id, 
	"Underpaid" AS comment   
FROM min_max_sal m 
JOIN SALARIES11 s 
ON m.employee_id = s.employee_id 
AND s.salary < m.min_salary;

WITH min_max_sal AS (
	SELECT 
		e.employee_id, 
		d.department_id, 
		d.min_salary, 
		d.max_salary  
	FROM EMPLOYEES11 e 
	JOIN DEPARTMENTS11 d 
	ON e.department_id = d.department_id
)
SELECT 
	m.employee_id, 
	"Overpaid" AS comment   
FROM min_max_sal m 
JOIN SALARIES11 s 
ON m.employee_id = s.employee_id 
AND s.salary > m.max_salary;

-- GOING TO UNION ALL

WITH min_max_sal AS (
	SELECT 
		e.employee_id, 
		d.department_id, 
		d.min_salary, 
		d.max_salary  
	FROM EMPLOYEES11 e 
	JOIN DEPARTMENTS11 d 
	ON e.department_id = d.department_id
),
overpaid_emp AS (
	SELECT 
		m.employee_id, 
		"Overpaid" AS comment   
	FROM min_max_sal m 
	JOIN SALARIES11 s 
	ON m.employee_id = s.employee_id 
	AND s.salary > m.max_salary
),
underpaid_emp AS (
	SELECT 
		m.employee_id, 
		"Underpaid" AS comment   
	FROM min_max_sal m 
	JOIN SALARIES11 s 
	ON m.employee_id = s.employee_id 
	AND s.salary < m.min_salary
),
missing_emp AS (
	SELECT 
		s.employee_id, "Missing Employee" AS Comment 
	FROM SALARIES11 s 
	LEFT JOIN EMPLOYEES11 e 
	ON s.employee_id = e.employee_id 
	WHERE e.employee_id IS NULL
),
missing_sal AS (
	SELECT 
		e.employee_id, "Missing Salary" AS Comment 
	FROM EMPLOYEES11 e 
	LEFT JOIN SALARIES11 s 
	ON e.employee_id = s.employee_id 
	WHERE s.employee_id IS NULL
)
SELECT * FROM overpaid_emp 
UNION ALL 
SELECT * FROM underpaid_emp 
UNION ALL 
SELECT * FROM missing_emp 
UNION ALL 
SELECT * FROM missing_sal 
ORDER BY employee_id;





