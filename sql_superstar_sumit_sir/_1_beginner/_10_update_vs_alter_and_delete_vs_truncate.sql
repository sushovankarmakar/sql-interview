DROP TABLE orders;
DROP TABLE customers;

CREATE TABLE retail_db.customers (
	customer_id int,
	customer_fname varchar(45) ,
	customer_lname varchar(45),
	customer_email varchar(45) ,
	customer_phone varchar(45) ,
	customer_street varchar(255) ,
	customer_city varchar(45) ,
	customer_state varchar(45) ,
	customer_zipcode varchar(45)
);

INSERT INTO retail_db.customers VALUES 
(1, 'fname', 'lname', 'a@mail.com', '123', 'street', 'city', 'state', 'zip'),
(2, 'fname', 'lname', 'a@mail.com', '456', 'street1', 'city1', 'state1', 'zip1');

SELECT * FROM retail_db.customers AS c; 

UPDATE customers AS c SET 
	c.customer_street = '8324 Little Common', 
	c.customer_city = 'San Marcos', 
	c.customer_state = 'CA1' 
WHERE customer_id = 2;

SELECT * FROM retail_db.customers AS c; 

ROLLBACK;

DELETE FROM customers AS c 
WHERE c.customer_id = 2;

DELETE FROM customers AS c;

truncate customers;



