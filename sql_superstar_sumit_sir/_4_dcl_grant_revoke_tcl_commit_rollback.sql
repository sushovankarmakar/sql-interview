-- create view
CREATE VIEW customer_v AS 
SELECT 
	customer_id, 
	customer_fname, 
	customer_lname, 
	customer_city, 
	customer_state, 
	customer_zipcode 
FROM customers;

SELECT * FROM customer_v LIMIT 10;

-- create user
CREATE USER 'analyticsx'@'localhost' IDENTIFIED BY 'analyticsx123';
-- grant access
GRANT SELECT ON retail_db.customer_v TO 'analyticsx'@'localhost';
-- revoke access
REVOKE SELECT ON retail_db.customer_v FROM 'analyticsx'@'localhost';

-- grant access
GRANT SELECT, DELETE, DROP ON retail_db.employees TO 'analyticsx'@'localhost';
-- revoke access
REVOKE DROP ON retail_db.employees FROM 'analyticsx'@'localhost';
-- drop user
DROP USER 'analyticsx'@'localhost';


USE information_schema;
SHOW TABLES;

SELECT * FROM tables WHERE table_schema = 'retail_db';
SELECT * FROM columns WHERE table_schema = 'retail_db';
