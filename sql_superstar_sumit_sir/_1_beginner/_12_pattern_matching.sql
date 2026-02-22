-- first name starts with J
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE 'J%';

-- first name ends with J
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE '%J';

-- first name starts with J and last name ends with h
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE 'J%' 
AND e.last_name LIKE '%h';

-- first name starts with Ja and ends with e
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE 'Ja%e';

-- first name starts with A and ends with a
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE 'A%a';

-- all employees where first name contains the word 'son;
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE '%son%';

-- job title includes the word 'manager'
SELECT * 
FROM employees AS e 
WHERE e.job_title LIKE '%manager%';

-- job title includes the word 'sales'
SELECT * 
FROM employees AS e 
WHERE e.job_title LIKE '%sales%';

-- job title includes the word 'developer' and from dept 2
SELECT * 
FROM employees AS e 
WHERE e.department_id = 2 AND 
e.job_title LIKE '%developer%';


-- first name is exactly of 4 characters
SELECT * 
FROM employees AS e 
WHERE e.first_name like '____';

-- first name is of 4 or more characters
SELECT * 
FROM employees AS e 
WHERE e.first_name like '____%';

-- in first name 1st char is A and third is e followed by anything
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE 'A_e%';

-- all employees where first name is of 4 chars and starts with J
SELECT * 
FROM employees AS e 
WHERE e.first_name LIKE 'J___';


SELECT * 
FROM employees AS e 
WHERE e.email NOT LIKE '_%@_%.__%';

-- search for all employees who have % in their email id
SELECT * 
FROM employees AS e 
WHERE email LIKE '%\%%';


-- firstname starting with A, B, C or D
SELECT * 
FROM employees AS e 
WHERE e.first_name REGEXP '^[ABCD]';

-- firstname ending with A, B, C or D
SELECT * 
FROM employees AS e 
WHERE e.first_name REGEXP '[ABCD]$';

-- in the firstname, the 2nd character is a vowel
SELECT * 
FROM employees AS e 
WHERE e.first_name REGEXP '^.[aeiou]';

-- in the firstname, the 7th character is a vowel
SELECT * 
FROM employees AS e 
WHERE e.first_name REGEXP '^......[aeiou]';

-- 2nd char is a vowel and 4th char is a vowel
SELECT * 
FROM employees AS e 
WHERE e.first_name REGEXP '^.[aeiou].[aeiou]';

-- in the firstname, the last character should be a vowel
SELECT * 
FROM employees AS e 
WHERE e.first_name REGEXP '[aeiou]$';


SELECT * 
FROM users 
WHERE email NOT REGEXP '^[a-z0-9._]+@[a-z0-9_]+\.[a-z]{2,}$';


SELECT * 
FROM users 
WHERE email REGEXP '^[^_\\-+]+@[a-z0-9_]+\.[a-z]{2,}$';



