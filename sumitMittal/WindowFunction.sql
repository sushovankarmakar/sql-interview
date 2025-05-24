-- WINDOW FUNCTION
-- https://www.youtube.com/watch?v=BsI_jp7CXXk&ab_channel=SumitMittal

CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(50),
	department VARCHAR(50),
	salary DECIMAL(10, 2),
	city VARCHAR(50),
	hire_date DATE
);

INSERT INTO employees (employee_id, employee_name, department, city,
salary, hire_date)
VALUES
(1, 'Amit', 'HR', 'Mumbai', 50000, '2022-01-15'),
(2, 'Neha', 'HR', 'Mumbai', 55000, '2023-03-10'),
(3, 'Suresh', 'HR', 'Delhi', 48000, '2021-11-20'),
(4, 'Rohit', 'HR', 'Delhi', 52000, '2022-09-05'),
(5, 'Raj', 'Finance', 'Mumbai', 60000, '2021-07-23'),
(6, 'Ravi', 'Finance', 'Delhi', 62000, '2022-09-01'),
(7, 'Kiran', 'Finance', 'Mumbai', 58000, '2021-02-14'),
(8, 'Sunita', 'Finance', 'Delhi', 61000, '2023-01-11'),
(9, 'Priya', 'IT', 'Mumbai', 70000, '2020-12-02'),
(10, 'Anjali', 'IT', 'Delhi', 67000, '2021-11-19'),
(11, 'Vikas', 'IT', 'Mumbai', 69000, '2022-05-20'),
(12, 'Sanjay', 'IT', 'Delhi', 72000, '2023-04-30'),
(13, 'Meena', 'IT', 'Delhi', 68000, '2021-03-15');


SELECT * FROM employees e ;

-- find max salary for each department

SELECT e.department, max(e.salary) AS max_salary
FROM employees e 
GROUP BY department ;

-- now find out, find max salary for each department AND print the employee_id and employee_name

SELECT e.department, max(e.salary) AS max_salary, e.employee_name, e.employee_id
FROM employees e 
GROUP BY department ;

-- the above SQL won't work.
-- now we're stuck, 
-- because, for each group (grouped by department), there are multiple employee
-- we can't provide the employee_name of the highest paid employee
-- although we can get the value using join.

SELECT *
FROM employees e1 
JOIN
(
	SELECT e.department, max(e.salary) AS max_salary
	FROM employees e 
	GROUP BY department
) AS e
ON e1.salary = e.max_salary;

-- although the above sql is tricky, 
-- but still we can achieve, 'find max salary for each department AND print the employee_id and employee_name'

-- https://youtu.be/BsI_jp7CXXk?t=760 -- uptil this, it is tells you that, we can't achieve everything using 'GROUP BY'

-- NOW we want,
-- I want top 2 employees with highest salary from each department

SELECT * FROM employees e ORDER BY e.salary DESC LIMIT 2;

-- above solution won't work because, it shows OVERALL top 2 highest salary, but not PER GROUP. 
-- so, using 'LIMIT 2' won't work here.
-- we want to show 2 employees from THAT GROUP i.e from take 2 employees from EACH GROUP.

------------------------------------------------------------------------------------------------------------------------- 
-- finding top 2 in each department
-- finding emp_id of highest salary per department 

-- these problems are hard to achieve using limit, group by
-- so,
-- these problems we can solve using 'WINDOW functions'
-- https://youtu.be/BsI_jp7CXXk?t=923


SELECT 
e.employee_id,
e.employee_name,
e.department,
e.salary,
e.hire_date,
row_number() OVER (PARTITION BY e.department ORDER BY salary DESC) AS row_num
FROM employees e;

-- window function

-- row_number
-- rank
-- dense_rank

-- syntax
-- <window_function> OVER (PARTITION BY <partitioning_column> ORDER BY <order_by_column> ASC/DESC) -- by default ASC

-- GROUP BY vs WINDOW function
------------------------------
-- We use GROUP BY, When we want to aggregate for each group
-- here we get a single row for each group
-- so there are 3 group, then we'll get 3 rows after group by

-- In Window function,
-- here we get the same number of row for each group
-- so here if there are 10 rows in actual data, then we'll get that many rows after window function
-- so in window function, the input and output data has same number of rows for each partitions


-- we can also remove PARTITION BY clause if needed - then the entire table becomes a big partition
SELECT e.employee_id,
e.employee_name,
e.department,
e.hire_date,
e.salary,
row_number() OVER (ORDER BY e.salary DESC) AS row_num
FROM employees e;

-- we can't remove ORDER BY clause. It is mandatory
-- altough the below query will run, but it is not correct
-- to get correct rank number, we must provide ORDER BY
SELECT e.employee_id,
e.employee_name,
e.department,
e.hire_date,
e.salary,
row_number() OVER (PARTITION BY e.department) AS row_num
FROM employees e;

-- so, partition by is optional BUT order by is mandatory

-- can we partition by more than one column ? YES
-- find top 2 highest salary from each department in each city
SELECT 
e.employee_name,
e.department, 
e.city,
e.hire_date,
e.salary,
row_number() OVER (
	PARTITION BY e.department, e.city 
	ORDER BY e.salary DESC, e.hire_date DESC
) AS row_num
FROM employees e; 
--WHERE row_num >= 2; -- You cannot directly use the ROW_NUMBER() window function in the WHERE clause 

-- You cannot directly use the ROW_NUMBER() window function in the WHERE clause 
-- because window functions are processed after the WHERE clause in SQL's logical query processing order. 
-- This is why you need an inner query (subquery or CTE) to first compute the window function, and then filter on its result.

-- Why can't you do it without an inner query or CTE?
-- Window functions are not allowed in the WHERE clause; they are computed after filtering rows.
-- You must compute the window function first, then filter the result.

-- with sub query
SELECT * FROM 
(SELECT 
	e.employee_name,
	e.department, 
	e.city,
	e.hire_date,
	e.salary,
	row_number() OVER (
		PARTITION BY e.department, e.city 
		ORDER BY e.salary DESC, e.hire_date DESC
	) AS row_num
	FROM employees e
) WHERE row_num <= 2;

-- with CTE
WITH emp_cte AS (SELECT 
	e.employee_name,
	e.department, 
	e.city,
	e.hire_date,
	e.salary,
	row_number() OVER (
		PARTITION BY e.department, e.city 
		ORDER BY e.salary DESC, e.hire_date DESC
	) AS row_num
	FROM employees e
) 
SELECT * FROM emp_cte e WHERE e.row_num <= 2; 











