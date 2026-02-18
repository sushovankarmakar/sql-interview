DROP TABLE customers;

CREATE TABLE customers (
		customer_id INT PRIMARY KEY,
		customer_fname VARCHAR(45),
		customer_lname VARCHAR(45),
		customer_email VARCHAR(45) UNIQUE KEY,
		customer_phone VARCHAR(45) UNIQUE KEY,
		customer_street VARCHAR(255),
		customer_city VARCHAR(45),
		customer_state VARCHAR(45),
		customer_zipcode VARCHAR(10)
);

INSERT INTO customers VALUES
(1,'Richard','Hernandez','richard@gmail.com','9191919191','6303 Heather Plaza','Brownsville','TX','78521');

INSERT INTO customers VALUES
(2,'Mary','Barrett','mary@gmail.com','9191919191','9526 Noble Embers Ridge','Littleton','CO','80126'); -- SQL Error [1062] [23000]: Duplicate entry '9191919191' for key 'customers.customer_phone'

INSERT INTO customers VALUES
(2,'Mary','Barrett','mary@gmail.com',null,'9526 Noble Embers Ridge','Littleton','CO','80126');

INSERT INTO customers VALUES
(3,'Mary','Barrett','Barrett@gmail.com',null,'9526 Noble Embers Ridge','Littleton','CO','80126');

SELECT * FROM customers AS c;  


DROP TABLE employees;

CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	hire_date DATE,
	status VARCHAR(10) DEFAULT 'active'
);

INSERT INTO employees VALUES (1, 'Kapil', 'Raj', '2023-07-01'); -- SQL Error [1136] [21S01]: Column count doesn't match value count at row 1

INSERT INTO employees 
(employee_id, first_name, last_name, hire_date)
VALUES 
(1, 'Kapil', 'Raj', '2023-07-01'); -- here, status is not given, so default value 'active' will be inserted.

INSERT INTO employees
VALUES 
(2, 'rahul', 'sharma', '2023-07-02', default);

INSERT INTO employees 
(employee_id, first_name, last_name, hire_date, status)
VALUES 
(3, 'Jane', 'Smith', '2023-07-01', 'inactive');

INSERT INTO employees 
(employee_id, first_name, last_name, hire_date, status)
VALUES 
(4, 'Jane', 'Smith', '2023-07-01', null);

SELECT * FROM employees;

DROP TABLE orders;

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	quantity INT,
	order_date DATE DEFAULT (CURRENT_DATE)
);

INSERT INTO orders 
(order_id, customer_id, product_id, quantity)
VALUES (1, 101, 202, 3); -- here, order_date is not given, so default value 'CURRENT_DATE' will be inserted.


INSERT INTO orders 
VALUES 
(2, 101, 202, 3, default);

INSERT INTO orders 
VALUES 
(3, 101, 202, 3, null);

SELECT * FROM orders AS o; 

DROP TABLE customers;

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country VARCHAR(50) DEFAULT 'USA'
);

INSERT INTO customers 
(customer_id, first_name, last_name)
VALUES 
(1, 'Alice', 'Smith'); -- here, country is not given, so default value 'USA' will be inserted.

INSERT INTO customers 
(customer_id, first_name, last_name, country)
VALUES 
(2, 'Alice', 'Smith', null);

SELECT * FROM customers AS c; 


DROP TABLE employees;

CREATE TABLE employees (
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	hire_date DATE
);

INSERT INTO employees (first_name, last_name, hire_date)
VALUES ('John', 'Doe', '2023-07-01');

SELECT * FROM employees AS e;

-- Set the starting value of the auto-increment to 1000
ALTER TABLE employees AUTO_INCREMENT = 1000;

INSERT INTO employees (first_name, last_name, hire_date)
VALUES ('John', 'Doe', '2023-07-01');

-- Set the auto-increment increment value to 2
SET @@auto_increment_increment = 2;



