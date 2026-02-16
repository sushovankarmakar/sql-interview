-- show all the databases
SHOW DATABASES;

-- create a database
CREATE DATABASE retail_db;

-- show the current database
SELECT database();

-- connect to a particular database
USE retail_db;

-- create table
CREATE TABLE orders(
	order_id int,
	order_date datetime,
	order_customer_id int,
	order_status varchar(45)
);

-- show tables under the current database
SHOW tables;

-- select table
SELECT * FROM retail_db.orders;

-- insert data into tables
/*
INSERT INTO orders VALUES (1, '2013-07-25 00:00:00.0', 11599, 'CLOSED');
INSERT INTO orders VALUES (2, '2013-07-25', 256, 'PENDING_PAYMENT');
*/

-- drop a table
DROP TABLE orders;

-- drop a database
DROP DATABASE retail_db;


-- create table: customers and insert 5 records 
-- create table: order_itemes and insert 5 records

-- creating a database
-- creating a table
-- inserting records
-- write a comment #
-- datatypes - int, varchar(30), date, datetime, float

-- schema
-- database_name -> schema -> tables
-- mysql do not have any schema structure
-- database_name -> tables



