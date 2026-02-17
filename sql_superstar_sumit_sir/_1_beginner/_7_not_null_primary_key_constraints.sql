DROP TABLE orders;

CREATE TABLE orders (
	order_id int NOT NULL,
	order_item_id int NOT NULL,
	order_date date NOT NULL,
	customer_id int NOT NULL,
	order_status varchar(20) NOT NULL,
	product_id int NOT NULL,
	quantity int NOT NULL,
	product_price float NOT NULL,
	total_price float NOT NULL
);

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

DESC orders;

DROP TABLE customers;

CREATE TABLE customers (
	customer_id int PRIMARY KEY,
	customer_fname varchar(45) NOT NULL,
	customer_lname varchar(45) NOT NULL,
	customer_email varchar(45) NOT NULL,
	customer_phone varchar(45),
	customer_street varchar(255),
	customer_city varchar(45) NOT NULL,
	customer_state varchar(45) NOT NULL,
	customer_zipcode varchar(10)
);

-- primary key
CREATE TABLE customers (
	customer_id int,
	customer_fname varchar(45) NOT NULL,
	customer_lname varchar(45) NOT NULL,
	customer_email varchar(45) NOT NULL,
	customer_phone varchar(45),
	customer_street varchar(255),
	customer_city varchar(45) NOT NULL,
	customer_state varchar(45) NOT NULL,
	customer_zipcode varchar(10),
	PRIMARY KEY (customer_id, customer_fname) -- composite primary key
);

DESC customers;


SELECT * 
FROM information_schema.TABLE_CONSTRAINTS AS tc 
WHERE tc.TABLE_NAME IN ('orders', 'customers');

ALTER TABLE customers 
DROP PRIMARY KEY;


