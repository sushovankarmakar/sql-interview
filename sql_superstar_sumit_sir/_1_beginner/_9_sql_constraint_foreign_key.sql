DROP TABLE customers;

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

DROP TABLE orders;

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	order_date DATE,
	customer_id INT,
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

INSERT INTO customers (customer_id, first_name, last_name)
VALUES (1, 'John', 'Doe');

INSERT INTO orders (order_id, order_date, customer_id)
VALUES (1, '2023-07-01', 1);

INSERT INTO orders (order_id, order_date, customer_id)
VALUES (2, '2023-07-02', 2); 
-- SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails 
-- (`retail_db`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))

DELETE FROM customers c WHERE c.customer_id = 1;

-- Delete related orders first
DELETE FROM orders o WHERE o.customer_id = 1;

-- Now delete the customer
DELETE FROM customers c WHERE c.customer_id = 1;

SELECT * FROM orders AS o; 
SELECT * FROM customers AS c;


-- FOREIGN KEY Constraint With ON DELETE CASCADE

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON DELETE CASCADE;

-- Now this will work and auto-delete related orders
DELETE FROM customers WHERE customer_id = 1;



-- FOREIGN KEY Constraint in many-to-many relationship
CREATE TABLE students (
	student_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

CREATE TABLE courses (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(100)
);

CREATE TABLE enrollments (
	student_id INT,
	course_id INT,
	enrollment_date DATE,
	PRIMARY KEY (student_id, course_id), -- composite primary key
	FOREIGN KEY (student_id) REFERENCES students (student_id),
	FOREIGN KEY (course_id) REFERENCES courses (course_id)
);


INSERT INTO students (student_id, first_name, last_name)
VALUES (1, 'Alice', 'Johnson');

INSERT INTO courses (course_id, course_name)
VALUES (101, 'Math 101');

INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES (1, 101, '2023-09-01');

INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES (1, 102, '2023-09-01');
-- SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails 
-- (`retail_db`.`enrollments`, CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`))


-- FOREIGN KEY Constraint With ON UPDATE CASCADE
DROP TABLE orders;
DROP TABLE customers;

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	order_date DATE,
	customer_id INT,
	FOREIGN KEY fk_orders_customer (customer_id) REFERENCES customers (customer_id) ON UPDATE CASCADE
);

SHOW CREATE TABLE orders;

INSERT INTO customers (customer_id, first_name, last_name)
VALUES (1, 'John', 'Doe');

INSERT INTO orders (order_id, order_date, customer_id)
VALUES (1, '2023-07-01', 1);

INSERT INTO orders (order_id, order_date, customer_id)
VALUES (2, '2023-07-02', 2);

SELECT * FROM customers AS c;
SELECT * FROM orders AS o; 

UPDATE customers AS c SET c.customer_id = 2 WHERE c.customer_id = 1;



-- SELF REFERENCING FOREIGN KEY
DROP TABLE employees;

CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	manager_id INT,
	FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
);

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (1, 'John', 'Doe', NULL);

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (2, 'Jane', 'Smith', 1);

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (3, 'Alice', 'Johnson', 99);

SELECT * FROM employees e;

