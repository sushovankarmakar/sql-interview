SELECT 
	DISTINCT customer_state 
FROM customers;

SELECT 
	COUNT(DISTINCT customer_state) AS distinct_count 
FROM customers;

SELECT 
	COUNT(DISTINCT customer_city) AS distinct_count 
FROM customers;

SELECT 
	DISTINCT department, role 
FROM employees_new;

SELECT 
	COUNT(DISTINCT department, role) 
FROM employees_new;

-- 5 candidates with highest experience 
SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 5;

-- candidates with 4th highest experience and 5th highest experience
SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 3,2;

SELECT * 
FROM students 
ORDER BY years_of_exp DESC 
LIMIT 0,2; -- starting from 0th row, we want 2 rows.

-- 3 candidates with least experience
SELECT *
FROM students
ORDER BY years_of_exp 
LIMIT 3;

SELECT DISTINCT(location)
FROM students;

SELECT DISTINCT(source_of_joining) 
FROM students;

-- from which sources the 5 most experienced candidates got to know about me.
SELECT source_of_joining
FROM students
ORDER BY years_of_exp DESC 
LIMIT 5;

-- the below query will not work (DISTINCT AND ORDER BY)
SELECT DISTINCT source_of_joining
FROM students
ORDER BY years_of_exp DESC 
LIMIT 5;


