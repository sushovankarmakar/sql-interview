-- number of records in customers table
SELECT COUNT(*) FROM customers AS c;

-- number of customers from CA
SELECT COUNT(*) FROM customers AS c WHERE c.customer_state = 'CA';
SELECT COUNT(1) AS total FROM customers AS c WHERE c.customer_state = 'CA';

-- get count of all the employees
SELECT COUNT(*) 
FROM employees AS e;

-- get count of employees who report to a manager
SELECT COUNT(manager_id) 
FROM employees AS e;

-- get number of employees who have salary > 50000
SELECT COUNT(*) FROM employees AS e 
WHERE e.salary > 50000;

-- get count of employees who are not managers and their salary is more than 50000
SELECT COUNT(manager_id) 
FROM employees AS e 
WHERE e.salary > 50000;