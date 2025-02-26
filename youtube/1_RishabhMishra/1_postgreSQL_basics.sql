-- https://www.youtube.com/watch?v=4YAAgrm8_ZI&list=PLdOKnrf8EcP17p05q13WXbHO5Z_JfXNpw&index=5&ab_channel=RishabhMishra

--create database mydb;
--drop database mydb; - deletes a table in the database
--truncate table table_name - deletes the data inside a table, but not the table itself

SELECT datname FROM pg_database; -- This will show you a list of all databases including your newly created ones

create table customer (
	"id" int8 primary key,
	"name" varchar(50) not null,
	"age" int not null,
	"city" char(50),
	"salary" numeric
);

-- catalog.schema.table
select * from postgres.public.customer c ;

-- drop table postgres.public.customer ; - deletes a table in the database
-- truncate table postgres.public.customer; - deletes the data inside a table, but not the table itself

insert into postgres.public.customer 
(id, name, age, city, salary) -- column names are case sensitive
values
(1, 'sushovan', 27, 'gurugram', 37),
(2, 'bou', 28, 'milan', 18),
(3, 'sharmistha', 27, 'howrah', 9);

update postgres.public.customer c 
set name = 'mampi', age = 28
where c.id = 2;

delete from postgres.public.customer where id = 1;

-- alter table statement is used to add, delete or modify columns in an existing table.
-- alter table table_name add column_name
-- alter table table_name delete column_name
-- alter table table_name alter column_name datatype
-- https://www.w3schools.com/sql/sql_alter.asp
alter table postgres.public.customer add skills varchar(50);

-- catalog.schema.table
update postgres.public.customer c set skills = 'cooking' where c.id = 3;

--\COPY postgres.public.customer(id, name, age, city, salary, skills)
--from 'C:\Users\susho\Downloads\Customer_examples.csv'
--with (format csv, header true, delimiter ',');

--insert into postgres.public.customer(id, name, age, city, salary, skills)
--select * 
--from csvread('C:\Users\susho\Downloads\Customer_examples.csv');

-- functions in SQL
-- functions in SQL are the database objects that contains a set of SQL statements to perform a specific task.
-- a function accepts input parameters, perform actions and then return the result
-- types of function
-- 1. system define function - example : rand(), round(), upper(), lower(), count(), sum(), max() etc
-- 2. user define function - once you define a function, you can call it in the same way as system define function.
-- https://www.w3schools.com/sql/sql_ref_mysql.asp
-- https://www.postgresql.org/docs/current/functions-string.html

-- string function
select 
	length(name), 
	UPPER(name), 
	LOWER(name), 
	substring(name, 1, 2), 
	concat(name, age), 
	replace(name, 'abc', 'sushovan'),
	trim(name),
	format('b%s', 'india'),
	now()
from customer c ;

-- aggregate function
-- it performs a calculation on multiple values and returns a single value
-- and aggregate functions are often used with GROUP BY and SELECT statement
-- https://www.postgresql.org/docs/9.5/functions-aggregate.html
select * from customer c where c.city = 'ggn';
select count(*), max(c.salary ), min(c.salary ), round(avg(c.salary ), 2), sum(c.salary ) from customer c ;

-- group by
-- the 'group by' statement group rows that have same values in summary rows
-- it is often used with aggregrate functions to group the result-set by one or more columns

-- having clause
-- the HAVING clause is used to apply a filter on the result of GROUP BY based on the specified condition
-- the WHERE clause places conditions on the selected columns
-- the HAVING clause places conditions on the groups created by GROUP BY clause.

select 
	skills, 
	sum(salary) as salary_sum, 
	round(avg(c.age ), 2) as age_avg 
from customer c 
where c.city = 'ggn'
group by skills
having sum(salary) >= 20
order by age_avg desc;

-- the order of execution
-- from 
-- where
-- group by 
-- having
-- order by 
-- limit

-- timestamp
-- the timestamp data type is used for values that contain both date and time parts
-- time : contains only time, format HH:MI:SS
-- date : contains only date, format YYYY-MM-DD
-- year : contains on year, format YYYY or YY
-- timestamp : contains date and time, format YYYY-MM-DD HH:MI:SS
-- timestamptz : contains date, time and time zone

-- timestamp functions/operators
show timezone;
select now();
select timeofday();
select current_time;
select current_date;

-- extract function
-- the extract() function extracts a part from a given date value.
-- syntax : select extract(month from date_field) from table
-- year
-- quarter
-- month
-- week
-- day
-- hour
-- minute
-- DOW - day of week
-- DOY - day of year

-- join and it's types

-- inner join 						-- returns records that have matching values in both tables
-- left join / left outer join      -- returns all records from left table, and the matched records from the right table
-- right join / right outer join	-- returns all records from right table, and the matched records from the left table
-- outer join / full join			-- returns all the records when there is a match in either left or right table

-- select * from customer AS c INNER JOIN payment AS p ON c.customer_id = p.customer_id;

-- SELF JOIN
-- a self join is a regular join in which a table is joined to itself
-- select t1.employee as employee_name, t2.employee as manager_name
-- from emp as t1
-- join emp as t2
-- where t1.empid = t2.manager_id;

-- UNION
-- the sql UNION clause/operator is used to combine/concatenate the results of two or more SELECT statements 
-- without returning any duplicate rows and keep unique rows in the result set.

-- to use this UNION clause, each SELECT statement must have
-- the same number of columns and expressions
-- the same data types
-- the same order of columns or expressions

-- syntax
-- SELECT column1, column2, column3, ...
-- FROM table1 
-- UNION
-- SELECT column1, column2, column3, ...
-- FROM table2

-- UNION ALL
-- the sql UNION ALL clause/operator is used to combine/concatenate the results of two or more SELECT statements
-- without removing any duplicate rows and keep all rows in the result set.

-- syntax
-- SELECT column1, column2, column3, ...
-- FROM table1
-- UNION ALL
-- SELECT column1, column2, column3, ...
-- FROM table2


-- SUB QUERY
-- a subquery or inner query or a nested query allows us to create complex query on the output of another query
-- subquery syntax involves two SELECT statements - outer query and inner query

-- syntax
-- SELECT column1, column2, column3, ...
-- FROM table1
-- WHERE column1 = (SELECT column1 FROM table2 WHERE condition);

-- details of customer whose salary is greater than the average salary of all customers
select * from customer c where c.salary > (
	select avg(salary) from customer c
);

select * from customer c where c.city IN (
	select c.city from customer c where name like 'r%'
);

-- EXISTS
-- the EXISTS operator is used to test for the existence of any record in a subquery
-- the EXISTS operator returns true if the subquery returns one or more records

-- syntax
-- SELECT column1, column2, column3, ...
-- FROM table1
-- WHERE EXISTS (SELECT column1 FROM table2 WHERE condition);




