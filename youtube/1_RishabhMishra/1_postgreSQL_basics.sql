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


-- WINDOW FUNCTION
-- Window functions applies aggregate, ranking and analytic functions 
-- over a group of rows related to one another
-- and OVER clause is used with WINDOW function to define that window

-- aggregate function vs window function
-- aggregate function 	: it performs a calculation on a set of values and returns a single value
-- window function 		: it performs a calculation across a set of table rows that are somehow related to the current row

-- syntax
-- SELECT column1, column2, column3, ..., fun() OVER 
-- ([<PARTITION BY clause>]
-- [<ORDER BY clause>]
-- [<ROWS or RANGE clause>])
-- FROM table1

-- select a function 	: fun() - this function can be aggregate functions, ranking functions or analytic functions
-- define a window		: OVER - PARTITION BY, ORDER BY, ROWS

-- window function terms
-- window function 	: applies aggregate, ranking and analytic functions over a particular window; for example, sum, avg, or row_number
-- expression		: is the name of the column that we want the window function to be applied to. this may not be necessary depending on what window function is used.
-- over 			: is just to signify that this is a window function
-- partition by		: is used to divide the result set into partitions and perform the function on each partition
-- order by			: is used to sort the rows in each partition. optional
-- rows				: is used to specify the window frame for the window function. optional

-- window function types
-- aggregate 		: sum(), avg(), count(), max(), min()
-- ranking			: row_number(), rank(), dense_rank(), percent_rank(), cume_dist(), ntile()
-- analytic/ value	: lag(), lead(), first_value(), last_value(), nth_value()



create table test_data (
	id int8 not null,
	category varchar(50) not null
);

-- drop table test_data;

insert into test_data 
(id, category)
values
(100, 'agni'),
(200, 'agni'),
(500, 'dharti'),
(700, 'dharti'),
(200, 'vayu'),
(300, 'vayu'),
(500, 'vayu');

select * from postgres.public.test_data;

-- window with aggregate function
select *, 
	sum(id) over(partition by category) as total,
	avg(id) over(partition by category) as avgerage,
	min(id) over(partition by category) as minimum,
	max(id) over(partition by category) as maximum,
	count(id) over(partition by category) as total_count,
	first_value(id) over(partition by category) as first_val,
	last_value(id) over(partition by category) as last_val,
	lag(id) over(partition by category) as lag_val,
	lead(id) over(partition by category) as lead_val,
	nth_value(id, 2) over(partition by category) as nth_val
from test_data td ;

-- 'rows between unbounded preceding and unbounded following' - this will give a SINGLE output based on all INPUT values/PARITION (if used)
select *,
	sum(id) over(order by id rows between unbounded preceding and unbounded following) as total,
	avg(id) over(order by id rows between unbounded preceding and unbounded following) as avgerage,
	min(id) over(order by id rows between unbounded preceding and unbounded following) as minimum,
	max(id) over(order by id rows between unbounded preceding and unbounded following) as maximum,
	count(id) over(order by id rows between unbounded preceding and unbounded following) as count,
	first_value(id) over(order by id rows between unbounded preceding and unbounded following) as first_val,
	last_value(id) over(order by id rows between unbounded preceding and unbounded following) as last_val,
	lag(id) over(order by id rows between unbounded preceding and unbounded following) as lag_val,
	lead(id) over(order by id rows between unbounded preceding and unbounded following) as lead_val,
	nth_value(id, 2) over(order by id rows between unbounded preceding and unbounded following) as nth_val
from test_data td ;

-- window with ranking function

select *,
	row_number() over(order by id) as row_num, -- row_number is used to give a unique number to each row
	row_number() over(partition by category) as row_num_by_category,
	rank() over(order by id) as rank, -- Creates gaps in ranking numbers when there are ties, 1,1,3,4,4,6,.. Use rank() when you want to show the actual position including ties and gaps
	dense_rank() over(order by id) as dense_rank, -- No gaps in ranking numbers, continues with next sequential number, 1,1,2,3,3,4,.. Use dense_rank() when you want consecutive rankings without gaps
	percent_rank() over(order by id) as percent_rank -- percent_rank is used to give the rank in percentage
from test_data td ;


-- window with analytical function
select *, 
	first_value(id) over(order by id) as first_val,
	last_value(id) over(order by id) as last_val,
	lag(id) over(order by id) as lag_val,
	lag(id, 2) over(order by id) as lag_val2,
	lead(id) over(order by id) as lead_val,
	lead(id, 2) over(order by id) as lead_val2,
	nth_value(id, 2) over(order by id) as nth_val
from test_data td ;
-- if you just want the single last value from whole column, use 'ROWS BETWEEN UNBOUNDED PRECEEDING AND UNBOUNDED FOLLOWING'
-- we can offset the LEAD and LAG values by providing a second parameter as 'n', default value is 1.


-- CASE statement and CASE expression
-- the CASE expression is used to compare one expression with a set of expressions in SQL
-- and return a value based on the result of the comparison
-- the CASE expression is similar to the IF-THEN-ELSE statement in other programming languages
-- the CASE expression goes through conditions and returns a value when the first condition is met
-- if no conditions are true, it returns the value in the ELSE clause
-- if there is no ELSE part and no conditions are true, it returns NULL

-- case statment syntax
CASE
	WHEN condition1 THEN result1
	WHEN condition2 THEN result2
	...
	ELSE result
END

-- example
-- select all customers and add a new column 'status' based on their salary
select
	case 
		when c.salary >= 15 then 'expensive'
		when c.salary < 15 then 'non-expensive'
		else 'nothing'
	end as status,
	c.* 
from customer c ;

-- case expression syntax
CASE expression
	WHEN value1 THEN result1
	WHEN value2 THEN result2
	...
	ELSE result
END

-- example
-- select all customers and add a new column 'city_name' based on their city
select 
	case city
		when 'ggn' then 'gurgaon'
		when 'kol' then 'kolkata'
		when 'bbsr' then 'bhubaneswar'
		else 'other'
	end as city_name,
	c.*
from customer c ;

-- Common Table Expression (CTE)
-- a common table expression (CTE) is a temporary result set created from a simple SELECT statement 
-- that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement

-- a CTE can be used to:
-- 1. create a recursive query
-- 2. reference the same table multiple times in the same query
-- 3. simplify complex queries
-- 4. improve the readability of a query
-- 5. improve the performance of a query
-- 6. create a view that can be used in multiple queries
-- 7. create a derived table

-- we can create a CTE using the WITH clause directly before SELECT, INSERT, UPDATE, DELETE or MERGE statement.
-- the CTE is defined by a query that starts with the WITH keyword followed by the name of the CTE and a query definition in parentheses.
-- the WITH clause can include one or more CTEs separated by a comma.

-- syntax
WITH cte_name AS (
	SELECT column1, column2, column3, ...
	FROM table_name
)
SELECT column1, column2, column3, ...
FROM cte_name;

-- example
-- select all customers and add a new column 'avg_salary_by_city' based on their city
-- and then select the name, city, salary and avg_salary_by_city
with my_cte as (
	select *, 
		avg(salary) over(partition by city) as avg_salary_by_city
	from customer c 
)
select name, city, salary, round(avg_salary_by_city,2) as avg_salary from my_cte ;

-- Recursive CTE
-- a recursive CTE is a CTE that references itself
-- a recursive CTE is useful when you need to query hierarchical data, such as organizational structure, bill of materials, or set of possible moves in a chess game

-- A recursive CTE has three elements:
-- 1. Non recursive term - the anchor member that starts the recursion
-- 2. Recursive term - one or more CTE query definitions joined with non-recursive term using UNION or UNION ALL operator
-- 3. Terminating condition - the condition that determines when to stop the recursion

-- syntax
WITH RECURSIVE cte_name AS (
	-- anchor member
	SELECT column1, column2, column3, ...
	FROM table_name
	UNION ALL
	-- recursive member
	SELECT column1, column2, column3, ...
	FROM cte_name
	WHERE condition
)

-- example
-- write a counting to generate a series of numbers from 1 to 3 without using any function
with recursive my_cte as (
	select 1 as n 			-- anchor member
	union all
	select n+1 from my_cte 	-- recursive member
	where n < 3)			-- terminating condition
select * from my_cte;

-- example
create table employees (
	emp_id serial primary key,
	emp_name varchar not null,
	manager_id int
);

insert into employees (
	emp_id, emp_name, manager_id
)
values
(1, 'Madhav', null),
(2, 'Sam', 1),
(3, 'Tom', 2),
(4, 'Arjun', 6),
(5, 'Shiva', 4),
(6, 'Keshav', 1),
(7, 'Damodar', 5);

with recursive EmpCTE as (
	-- anchor query
	select emp_id, emp_name, manager_id from employees
	where emp_id = 7
	
	union all
	
	-- recursive query
	select employees.emp_id, employees.emp_name, employees.manager_id
	from employees 
	join EmpCTE
	on employees.emp_id = EmpCTE.manager_id 
)
select * from EmpCTE;

-- output
-- 7	Damodar	5
-- 5	Shiva	4
-- 4	Arjun	6
-- 6	Keshav	1
-- 1	Madhav	(null)

-- use cases of recursive CTE
-- 1. count up until a certain number
-- 2. finding bosses and hierarchical level of all employess
-- 3. finding all possible moves in a chess game
-- 4. finding all possible paths in a maze
-- 5. finding all possible routes between two cities
-- 6. finding ancestors  