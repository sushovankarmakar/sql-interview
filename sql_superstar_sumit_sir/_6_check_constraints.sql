CREATE TABLE orders (
	order_id int, 
	order_item_id int, 
	order_date date, 
	customer_id int, 
	order_status varchar(20), 
	product_id int, 
	quantity int, 
	product_price float, 
	total_price float
);

SELECT * FROM orders;

INSERT INTO orders VALUES (1, 1, '2013-07-25', 11599, 'CLOSE', 957, 1, 299.98, 299.98);

ALTER TABLE orders ADD CHECK (
	order_status in (
		'CLOSED', 
		'PENDING_PAYMENT', 
		'COMPLETE', 
		'PROCESSING', 
		'ON_HOLD',
		'SUSPECTED_FRAUD', 
		'PENDING'
	)
);

DELETE FROM orders;

SHOW CREATE TABLE orders;

INSERT INTO orders VALUES (1, 1, '2013-07-25', 11599, 'CLOSE', 957, 1, 299.98, 299.98);

ALTER TABLE orders 
DROP CHECK orders_chk_1;

ALTER TABLE orders 
ADD CONSTRAINT CHK_OrderStatus CHECK (
	order_status in (
		'CLOSED', 
		'PENDING_PAYMENT', 
		'COMPLETE', 
		'PROCESSING', 
		'ON_HOLD',
		'SUSPECTED_FRAUD', 
		'PENDING'
	)
);

SELECT * FROM information_schema.CHECK_CONSTRAINTS AS cc;

DROP TABLE orders;

CREATE TABLE orders ( 
	order_id INT, 
	order_item_id INT, 
	order_date DATE, 
	customer_id INT, 
	order_status VARCHAR(20) CONSTRAINT CHK_OrderStatus CHECK (order_status in ('CLOSED','PENDING_PAYMENT','COMPLETE','PROCESSING','ON_HOLD', 'SUSPECTED_FRAUD','PENDING')), 
	product_id INT, 
	quantity INT CONSTRAINT CHK_OrderQuantity CHECK (quantity <= 50), 
	product_price FLOAT, 
	total_price FLOAT
);

INSERT INTO orders VALUES (1, 1, '2013-07-25', 11599, 'CLOSED', 957, 52, 299.98, null);

DROP TABLE persons;

CREATE TABLE persons ( 
	person_id INT, 
	first_name VARCHAR(50), 
	last_name VARCHAR(50), 
	age INT CONSTRAINT CHK_age CHECK (age > 0)
);

INSERT INTO persons (person_id, first_name, last_name, age) VALUES (1, 'Raj', 'Sharma', -5);

CREATE TABLE users ( 
	user_id INT, 
	username VARCHAR(50), 
	email VARCHAR(100), 
	CHECK (email LIKE '%@%.%')
);

INSERT INTO users (user_id, username, email) VALUES (1, 'sumitm', 'sumit@trendytech.in');

SELECT * FROM users;

CREATE TABLE projects ( 
	project_id INT, 
	project_name VARCHAR(100), 
	start_date DATE, 
	end_date DATE, 
	CHECK (end_date > start_date) 
);

INSERT INTO projects 
(project_id, project_name, start_date, end_date) 
VALUES 
(1, 'Project Alpha', '2023-01-01', '2023-12-31');

INSERT INTO projects 
(project_id, project_name, start_date, end_date) 
VALUES 
(1, 'Project Beta', '2023-01-01', '2022-12-31');
