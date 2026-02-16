USE retail_db;

SHOW tables;
DESCRIBE orders;

-- drop previous & start fresh
DROP TABLE orders;

CREATE TABLE orders (
	order_id int,
	order_item_id int,
	order_date date,
	customer_id int,
	product_id int,
	quantity int,
	product_price float,
	total_price float
);

DESCRIBE orders;

INSERT INTO orders VALUES
(1, 1, '2013-07-25', 11599, 957, 1, 299.98, 299.98), 
(2, 2, '2013-07-25', 256, 1073, 1, 199.99, 199.99), 
(2, 3, '2013-07-25', 256, 502, 5, 50.00, 250.00), 
(2, 4, '2013-07-25', 256, 403, 1, 129.99, 129.99), 
(4, 5, '2013-07-25', 8827, 897, 2, 24.99, 49.98), 
(4, 6, '2013-07-25', 8827, 365, 5, 59.99, 299.95), 
(4, 7, '2013-07-25', 8827, 502, 3, 50.00, 150.00), 
(4, 8, '2013-07-25', 8827, 1014, 4, 49.98, 199.92), 
(5, 9, '2013-07-25', 11318, 957, 1, 299.98, 299.98), 
(5, 10, '2013-07-25', 11318, 365, 5, 59.99, 299.95), 
(5, 11, '2013-07-25', 11318, 1014, 2, 49.98, 99.96), 
(5, 12, '2013-07-25', 11318, 957, 1, 299.98, 299.98), 
(5, 13, '2013-07-25', 11318, 403, 1, 129.99, 129.99);

SELECT * FROM orders;

-- add a new column named order_status
ALTER TABLE orders ADD COLUMN order_status varchar(20);

-- As the table structure has changed, 
-- so now, column count doesn't match value count 
-- and the below insert query will fail
INSERT INTO orders
VALUES (7, 14, '2013-07-25', 4530, 1073, 1, 199.99, 199.99);

-- so, it is always a good practice to provide column names in the insert statement.
INSERT INTO orders 
(order_id, order_item_id, order_date, customer_id, product_id, quantity, product_price, total_price)
VALUES (7, 14, '2013-07-25', 4530, 1073, 1, 199.99, 199.99);


INSERT INTO orders 
(order_id, order_item_id, order_date, customer_id, order_status, product_id, quantity, product_price, total_price) 
VALUES 
(7, 14, '2013-07-25', 4530, 'COMPLETE', 1073, 1, 199.99, 199.99), 
(7, 15, '2013-07-25', 4530, 'COMPLETE', 957, 1, 299.98, 299.98), 
(7, 16, '2013-07-25', 4530, 'COMPLETE', 926, 5, 15.99, 79.95);


INSERT INTO orders 
(order_id, order_item_id, order_date, customer_id, order_status, product_id, quantity, product_price, total_price) 
VALUES 
(8, 17, '2013-07-25', 2911, null, 365, 3, 59.99, 179.97),
(8, 18, '2013-07-25', 2911, null, 365, 5, 59.99, 299.95),
(8, 19, '2013-07-25', 2911, null, 1014, 4, 49.98, 199.92), 
(8, 20, '2013-07-25', 2911, null, 502, 1, 50.00, 50.00);


ALTER TABLE orders DROP COLUMN total_price;

DESCRIBE orders;



ALTER TABLE orders MODIFY order_date DATETIME;
ALTER TABLE orders MODIFY order_date DATE;


INSERT INTO orders 
(order_id, order_item_id, order_date, customer_id, order_status, product_id, quantity, product_price) 
VALUES 
(7, 14, '2013-07-25 12:42:30', 4530, 'COMPLETE', 1073, 1, 199.99), 
(7, 15, '2013-07-25', 4530, 'COMPLETE', 957, 1, 299.98), 
(7, 16, '2013-07-25', 4530, 'COMPLETE', 926, 5, 15.99);

-- change the column name
ALTER TABLE orders RENAME COLUMN order_date TO order_time;

-- change column datatype (float to int)
ALTER TABLE orders MODIFY product_price int;

-- change column product_id (int to varchar)
ALTER TABLE orders MODIFY product_id varchar(5); 

-- change column customer_id (int to varchar)
ALTER TABLE orders MODIFY customer_id varchar(3); 

-- change (datetime to int)
ALTER TABLE orders MODIFY order_time int;

-- change (datetime to varchar)
ALTER TABLE orders MODIFY order_time varchar(50); 

-- change (varchar to date)
ALTER TABLE orders MODIFY order_time date;


ALTER TABLE orders MODIFY order_status int;

DELETE FROM orders WHERE order_status = 'COMPLETE';
ALTER TABLE orders MODIFY order_status int;

SHOW tables;

-- rename the table as orders_with_status
ALTER TABLE orders RENAME TO orders_with_status;

