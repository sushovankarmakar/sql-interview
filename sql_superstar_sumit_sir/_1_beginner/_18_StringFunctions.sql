SELECT 
	*, 
	CONCAT(customer_fname,' ', customer_lname) AS full_name,
	CONCAT(customer_street, ',', customer_city, ',', customer_state) AS address 
FROM customers AS c;

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name 
FROM employees e;

SELECT 
	*, 
	LENGTH(customer_fname) AS name_length
FROM customers AS c;

SELECT 
	first_name, 
	LENGTH(first_name) AS name_length
FROM employees AS e;

SELECT 
	first_name, 
	LENGTH(first_name) AS name_length
FROM employees AS e 
WHERE LENGTH(first_name) = 8;

SELECT LENGTH('Sushovan Karmakar');


SELECT LOWER('SQL Champion Program');
SELECT UPPER('SQL Champion Program');



SELECT SUBSTRING('Hello World', 7, 5);
SELECT SUBSTRING('Hello World', 3);
SELECT SUBSTRING('Hello World', -5); -- last 5 characters of the string.

SELECT 
	customer_fname, 
	SUBSTRING(customer_fname, -4) -- last 4 characters
FROM customers;

SELECT SUBSTRING('Hello World', 1);

SELECT TRIM(' SQL Champion Program '); -- trim both side
SELECT LTRIM(' SQL Champion Program '); -- trim left side
SELECT RTRIM(' SQL Champion Program '); -- trim right side

-- find all the customers with leading or trailing spaces in customer_street
SELECT *
FROM customers
WHERE TRIM(customer_street) != customer_street;

SELECT *
FROM customers
WHERE TRIM(customer_city) != customer_city;


SELECT REPLACE('Hello World', 'World', 'MySQL');

SELECT REPLACE('Hello Hello World Hello', 'Hello', 'MySQL');

SELECT 
	customer_id, 
	customer_fname, 
	REPLACE(customer_state, 'CA' , 'CALIFORNIA') 
FROM customers;


SELECT LOCATE('World', 'Hello World') AS position; -- 7
SELECT INSTR('Hello World', 'World') AS position; -- 7
SELECT LOCATE('l', 'Hello World') AS position; -- 3
SELECT LOCATE('L', 'Hello World') AS position; -- 3
SELECT LOCATE('a', 'Hello World') AS position; -- 0


SELECT 
	*, 
	SUBSTR(customer_street, 1, LOCATE(' ', customer_street) - 1) AS street_number 
FROM customers;






