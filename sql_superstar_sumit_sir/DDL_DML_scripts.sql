drop table employees;

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    manager_id INT,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    job_title VARCHAR(50)
);

INSERT INTO employees (first_name, last_name, department_id, salary, hire_date, manager_id, email, phone_number, job_title)
VALUES 
('John', 'Doe', 1, 60000, '2018-01-15', NULL, 'john.doe@example.com', '555-1234', 'Manager'),
('Jane', 'Smith', 2, 50000, '2019-03-22', 1, 'jane.smith@example.com', '555-5678', 'Developer'),
('Michael', 'Johnson', 1, 45000, '2020-06-11', 1, 'michael.johnson@example.com', '555-8765', 'Analyst'),
('Emily', 'Davis', 3, 55000, '2017-09-30', NULL, 'emily.davis@example.com', '555-3456', 'Sales'),
('Daniel', 'Wilson', 3, 40000, '2018-11-10', 4, 'daniel.wilson@example.com', '555-6543', 'Sales Representative'),
('Sophia', 'Martinez', 2, 47000, '2021-01-25', 2, 'sophia.martinez@example.com', '555-7890', 'Developer'),
('James', 'Brown', 1, 38000, '2020-04-18', 1, 'james.brown@example.com', '555-1239', 'Support'),
('Olivia', 'Jones', 2, 62000, '2019-07-21', 1, 'olivia.jones@example.com', '555-4321', 'Lead Developer'),
('William', 'Garcia', 3, 52000, '2018-12-01', NULL, 'william.garcia@example.com', '555-5670', 'Sales Manager'),
('Isabella', 'Miller', 2, 48000, '2020-08-15', 2, 'isabella.miller@example.com', '555-6789', 'QA Engineer'),
('Alex', 'White', 1, 61000, '2020-11-23', 1, 'alex.white@example.com', '555-2345', 'HR Specialist'),
('Liam', 'Lee', 2, 55000, '2017-05-19', 8, 'liam.lee@example.com', '555-3457', 'Developer'),
('Emma', 'Clark', 3, 58000, '2021-03-14', 4, 'emma.clark@example.com', '555-4568', 'Sales Executive'),
('Noah', 'Lopez', 1, 43000, '2019-12-10', 1, 'noah.lopez@example.com', '555-5679', 'HR Assistant'),
('Ava', 'Gonzalez', 2, 49000, '2018-07-25', 2, 'ava.gonzalez@example.com', '555-6780', 'QA Analyst'),
('Mason', 'Harris', 3, 61000, '2016-08-29', 4, 'mason.harris@example.com', '555-7891', 'Senior Sales Manager'),
('Ethan', 'Walker', 1, 42000, '2021-02-10', 1, 'ethan.walker@example.com', '555-8901', 'HR Coordinator'),
('Mia', 'Young', 2, 57000, '2018-09-15', 8, 'mia.young@example.com', '555-9012', 'Developer'),
('Logan', 'Hall', 3, 45000, '2020-05-17', 4, 'logan.hall@example.com', '555-1230', 'Sales Associate'),
('Charlotte', 'Allen', 2, 53000, '2019-01-20', 8, 'charlotte.allen@example.com', '555-2341', 'UI/UX Designer'),
('Benjamin', 'King', 1, 47000, '2017-11-22', 1, 'benjamin.king@example.com', '555-3452', 'HR Manager'),
('Amelia', 'Wright', 2, 50000, '2020-06-13', 8, 'amelia.wright@example.com', '555-4563', 'Software Tester'),
('Lucas', 'Scott', 3, 49000, '2016-10-30', 4, 'lucas.scott@example.com', '555-5674', 'Sales Coordinator'),
('Ella', 'Green', 1, 53000, '2018-02-14', 1, 'ella.green@example.com', '555-6785', 'HR Specialist'),
('Aiden', 'Adams', 2, 51000, '2019-08-26', 8, 'aiden.adams@example.com', '555-7896', 'Backend Developer'),
('Grace', 'Baker', 3, 52000, '2021-04-21', 4, 'grace.baker@example.com', '555-8907', 'Sales Analyst'),
('Oliver', 'Nelson', 1, 45000, '2020-01-19', 1, 'oliver.nelson@example.com', '555-9018', 'HR Associate'),
('Avery', 'Carter', 2, 60000, '2017-12-11', 8, 'avery.carter@example.com', '555-1239', 'Front-End Developer'),
('Matthew', 'Mitchell', 3, 48000, '2018-06-07', 4, 'matthew.mitchell@example.com', '555-2340', 'Sales Representative'),
('Harper', 'Perez', 2, 56000, '2019-03-28', 8, 'harper.perez@example.com', '555-3451', 'Quality Assurance'),
('Alice', 'Wonder', 2, 45000, '2022-07-13', 2, 'alice.wonderexample.com', '555-9999', 'Intern'),
('Bob', 'Builder', 3, 48000, '2021-11-10', 3, 'bob%builder@example.com', '555-8888', 'Technician');


drop table users;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

INSERT INTO users (email) VALUES
('john.doe@example.com'),
('jane_smith123@example.org'),
('michael.jordan@basketball.co'),
('invalid-email@example'),
('sarah.connor@techfuture.net'),
('tony.stark@starkindustries.com'),
('bruce_wayne@wayneenterprises.biz'),
('peter.parker@spiderman.com'),
('invalid-email@.com'),
('clark.kent@dailyplanet.news'),
('diana.prince@themyscira.gov'),
('steve.rogers@avengers.us'),
('invalid-email@example..com'),
('natasha.romanoff@shield.int'),
('valid.email+alias@example.org'),
('bruce.banner@hulk.com'),
('barry.allen@flash.city'),
('arthur.curry@atlantis.ocean'),
('diana.prince@amazon.wonder'),
('invalid-email@example@domain.com'),
('oliver.queen@arrow.ind'),
('hal.jordan@greenlantern.space');



CREATE TABLE employees_new (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
);

INSERT INTO employees_new (name, department, role) VALUES
('John Doe', 'Sales', 'Manager'),
('Jane Smith', 'Sales', 'Representative'),
('Alice Johnson', 'Marketing', 'Manager'),
('Chris Lee', 'IT', 'Developer'),
('Jack White', 'Sales', 'Representative'),
('Eve Davis', 'IT', 'Support'),
('Frank Brown', 'Marketing', 'Representative'),
('Grace Wilson', 'HR', 'Manager'),
('Henry Taylor', 'HR', 'Recruiter'),
('Chris Lee', 'IT', 'Developer');




DROP TABLE enrollments;
DROP TABLE students;

create table students(
	student_id INT AUTO_INCREMENT,
	student_fname varchar(30) NOT NULL,
	student_lname varchar(30) NOT NULL,
	student_mname varchar(30),
	student_email varchar(30) NOT NULL,
	student_phone varchar(15) NOT NULL,
	student_alternate_phone varchar(15),
	years_of_exp INT NOT NULL,
	student_company varchar(30),
	batch_date varchar(30) NOT NULL,
	source_of_joining varchar(30) NOT NULL,
	location varchar(30) NOT NULL,
	PRIMARY KEY(student_id),
	UNIQUE KEY(student_email)
);









INSERT INTO students(student_fname, student_lname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES ('Amit', 'Sharma', 'amit.sharma@gmail.com', '9191919191', 6, 'Walmart', '05-02-2021', 'LinkedIn', 'Bangalore');

INSERT INTO students(student_fname, student_lname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES ('Priya', 'Rao', 'priya.rao@gmail.com', '9292929292', 3, 'Flipkart', '05-02-2021', 'LinkedIn', 'Hyderabad');

INSERT INTO students(student_fname, student_lname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES ('Rahul', 'Verma', 'rahul.verma@gmail.com', '9393939393', 12, 'Google', '19-02-2021', 'Google', 'Bangalore');

INSERT INTO students(student_fname, student_lname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES ('Anjali', 'Singh', 'anjali.singh@gmail.com', '9494949494', 8, 'Walmart', '19-02-2021', 'Quora', 'Chennai');

INSERT INTO students(student_fname, student_lname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES ('Vikram', 'Patel', 'vikram.patel@gmail.com', '9294919191', 15, 'Microsoft', '05-02-2021', 'Friend', 'Pune'),
('Asha', 'Menon', 'asha.menon@gmail.com', '9394919191', 18, 'TCS', '05-02-2021', 'YouTube', 'Pune'),
('Kiran', 'Nair', 'kiran.nair@gmail.com', '9293519191', 20, 'Wipro', '19-02-2021', 'YouTube', 'Pune'),
('Ravi', 'Iyer', 'ravi.iyer@gmail.com', '9291975191', 14, 'Wipro', '19-02-2021', 'Google', 'Chennai');

========


CREATE TABLE IF NOT EXISTS sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    amount DECIMAL(10, 2),
    sale_date DATE,
    quantity INT,
    customer_id INT,
    store_location VARCHAR(50)
);

SELECT * FROM sales AS s;




CREATE TABLE orders1 (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	quantity INT,
	order_date DATE,
	total_amount DECIMAL(10, 2)
);

INSERT INTO orders1 (customer_id, product_id, quantity, order_date, total_amount)
VALUES
(1, 101, 2, CURRENT_DATE, 199.98),
(2, 102, 1, CURRENT_DATE, 99.99),
(3, 103, 5, CURRENT_DATE, 499.95),
(4, 104, 3, CURRENT_DATE, 299.97),
(5, 105, 4, CURRENT_DATE, 399.96);

CREATE TABLE products (
	product_name VARCHAR(50),
	discount_price DECIMAL(10, 2),
	regular_price DECIMAL(10, 2)
);

INSERT INTO products (product_name, discount_price, regular_price) VALUES
('Laptop', NULL, 1200.00),
('Smartphone', 800.00, 1000.00),
('Tablet', NULL, 300.00);

CREATE TABLE orders (
	order_id INT,
	billing_address VARCHAR(100),
	shipping_address VARCHAR(100),
	customer_address VARCHAR(100)
);

INSERT INTO orders (order_id, billing_address, shipping_address, customer_address) VALUES
(1, '123 Main St', NULL, '789 Oak Ave'),
(2, NULL, '456 Maple Rd', '101 Pine St'),
(3, NULL, NULL, '303 Elm St');

CREATE TABLE sales_new (
	sale_id INT,
	online_sales DECIMAL(10, 2),
	store_sales DECIMAL(10, 2)
);

INSERT INTO sales_new (sale_id, online_sales, store_sales) VALUES
(1, 1500.50, NULL),
(2, NULL, 2500.75),
(3, 1000.25, 500.00);



CREATE TABLE purchases (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100),
	purchase_date DATE
);
INSERT INTO purchases (customer_id, first_name, last_name, email, purchase_date) VALUES
(101, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '2024-07-05'),
(102, 'Vihaan', 'Singh', 'vihaan.singh@example.com', '2024-06-25'),
(103, 'Aditi', 'Mehta', 'aditi.mehta@example.com', '2024-07-15'),
(104, 'Rohan', 'Kumar', 'rohan.kumar@example.com', '2024-07-12'),
(105, 'Isha', 'Patel', 'isha.patel@example.com', '2024-07-18'),
(106, 'Kavya', 'Verma', 'kavya.verma@example.com', '2024-06-28'),
(107, 'Arjun', 'Reddy', 'arjun.reddy@example.com', '2024-07-09'),
(108, 'Anaya', 'Nair', 'anaya.nair@example.com', '2024-07-22'),
(109, 'Saanvi', 'Gupta', 'saanvi.gupta@example.com', '2024-07-20'),
(110, 'Kabir', 'Agarwal', 'kabir.agarwal@example.com', '2024-07-19'),
(111, 'Neha', 'Saxena', 'neha.saxena@example.com', '2024-06-24'),
(112, 'Tanishq', 'Rana', 'tanishq.rana@example.com', '2024-07-10'),
(113, 'Mira', 'Bhatt', 'mira.bhatt@example.com', '2024-07-21'),
(114, 'Dev', 'Kapoor', 'dev.kapoor@example.com', '2024-07-17'),
(115, 'Riya', 'Joshi', 'riya.joshi@example.com', '2024-07-11');


CREATE TABLE newsletter_subscriptions (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100),
	subscription_date DATE
);
INSERT INTO newsletter_subscriptions (customer_id, first_name, last_name, email, subscription_date) VALUES
(101, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '2024-07-01'),
(109, 'Saanvi', 'Gupta', 'saanvi.gupta@example.com', '2024-07-05'),
(116, 'Lakshay', 'Malhotra', 'lakshay.malhotra@example.com', '2024-06-29'),
(112, 'Tanishq', 'Rana', 'tanishq.rana@example.com', '2024-07-03'),
(117, 'Sneha', 'Chawla', 'sneha.chawla@example.com', '2024-07-15'),
(113, 'Mira', 'Bhatt', 'mira.bhatt@example.com', '2024-06-30'),
(118, 'Rahul', 'Pillai', 'rahul.pillai@example.com', '2024-07-06'),
(105, 'Isha', 'Patel', 'isha.patel@example.com', '2024-07-18'),
(106, 'Kavya', 'Verma', 'kavya.verma@example.com', '2024-07-20'),
(115, 'Riya', 'Joshi', 'riya.joshi@example.com', '2024-07-22'),
(119, 'Nikhil', 'Chandra', 'nikhil.chandra@example.com', '2024-07-08'),
(107, 'Arjun', 'Reddy', 'arjun.reddy@example.com', '2024-07-10'),
(108, 'Anaya', 'Nair', 'anaya.nair@example.com', '2024-07-13'),
(114, 'Dev', 'Kapoor', 'dev.kapoor@example.com', '2024-07-14'),
(104, 'Rohan', 'Kumar', 'rohan.kumar@example.com', '2024-07-11');


-- DROP TABLE RETURNS;
CREATE TABLE returns (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100),
	return_date DATE
);
INSERT INTO returns (customer_id, first_name, last_name, email, return_date) VALUES
(103, 'Aditi', 'Mehta', 'aditi.mehta@example.com', '2024-07-17'),
(102, 'Vihaan', 'Singh', 'vihaan.singh@example.com', '2024-07-14'),
(104, 'Rohan', 'Kumar', 'rohan.kumar@example.com', '2024-07-19'),
(110, 'Kabir', 'Agarwal', 'kabir.agarwal@example.com', '2024-07-08'),
(105, 'Isha', 'Patel', 'isha.patel@example.com', '2024-07-21'),
(107, 'Arjun', 'Reddy', 'arjun.reddy@example.com', '2024-07-10'),
(111, 'Neha', 'Saxena', 'neha.saxena@example.com', '2024-07-16'),
(116, 'Lakshay', 'Malhotra', 'lakshay.malhotra@example.com', '2024-07-02'),
(117, 'Sneha', 'Chawla', 'sneha.chawla@example.com', '2024-07-18'),
(112, 'Tanishq', 'Rana', 'tanishq.rana@example.com', '2024-07-07'),
(108, 'Anaya', 'Nair', 'anaya.nair@example.com', '2024-07-09'),
(114, 'Dev', 'Kapoor', 'dev.kapoor@example.com', '2024-07-11'),
(109, 'Saanvi', 'Gupta', 'saanvi.gupta@example.com', '2024-07-12'),
(113, 'Mira', 'Bhatt', 'mira.bhatt@example.com', '2024-07-20'),
(101, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '2024-07-22');



DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_department_id` int(11) NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
)

INSERT INTO `categories` VALUES (1,2,'Football'),(2,2,'Soccer'),(3,2,'Baseball & Softball'),(4,2,'Basketball'),(5,2,'Lacrosse'),(6,2,'Tennis & Racquet'),(7,2,'Hockey'),(8,2,'More Sports'),(9,3,'Cardio Equipment'),(10,3,'Strength Training'),(11,3,'Fitness Accessories'),(12,3,'Boxing & MMA'),(13,3,'Electronics'),(14,3,'Yoga & Pilates'),(15,3,'Training by Sport'),(16,3,'As Seen on  TV!'),(17,4,'Cleats'),(18,4,'Men\'s Footwear'),(19,4,'Women\'s Footwear'),(20,4,'Kids\' Footwear'),(21,4,'Featured Shops'),(22,4,'Accessories'),(23,5,'Men\'s Apparel'),(24,5,'Women\'s Apparel'),(25,5,'Boys\' Apparel'),(26,5,'Girls\' Apparel'),(27,5,'Accessories'),(28,5,'Top Brands'),(29,5,'Shop By Sport'),(30,6,'Men\'s Golf Clubs'),(31,6,'Women\'s Golf Clubs'),(32,6,'Golf Apparel'),(33,6,'Golf Shoes'),(34,6,'Golf Bags & Carts'),(35,6,'Golf Gloves'),(36,6,'Golf Balls'),(37,6,'Electronics'),(38,6,'Kids\' Golf Clubs'),(39,6,'Team Shop'),(40,6,'Accessories'),(41,6,'Trade-In'),(42,7,'Bike & Skate Shop'),(43,7,'Camping & Hiking'),(44,7,'Hunting & Shooting'),(45,7,'Fishing'),(46,7,'Indoor/Outdoor Games'),(47,7,'Boating'),(48,7,'Water Sports'),(49,8,'MLB'),(50,8,'NFL'),(51,8,'NHL'),(52,8,'NBA'),(53,8,'NCAA'),(54,8,'MLS'),(55,8,'International Soccer'),(56,8,'World Cup Shop'),(57,8,'MLB Players'),(58,8,'NFL Players');

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_fname` varchar(45) NOT NULL,
  `customer_lname` varchar(45) NOT NULL,
  `customer_email` varchar(45) NOT NULL,
  `customer_password` varchar(45) NOT NULL,
  `customer_street` varchar(255) NOT NULL,
  `customer_city` varchar(45) NOT NULL,
  `customer_state` varchar(45) NOT NULL,
  `customer_zipcode` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_id`)
)

CREATE TABLE employees1 (
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(100),
	department_id INT,
	manager_id INT,
	salary DECIMAL(10, 2)
);

INSERT INTO employees1 (employee_id, employee_name, department_id, manager_id, salary) VALUES
(1, 'Rajesh Kumar', 1, NULL, 200000.00), -- CEO, No manager
(2, 'Sonal Gupta', 2, 1, 150000.00), -- VP IT, reports to Rajesh Kumar
(3, 'Anita Desai', 2, 2, 120000.00), -- Manager IT, reports to Sonal Gupta
(4, 'Vikram Singh', 3, 1, 110000.00), -- VP HR, reports to Rajesh Kumar
(5, 'Priya Nair', 2, 3, 130000.00), -- Developer IT, reports to Anita Desai
(6, 'Amit Sharma', 3, 4, 100000.00), -- HR Manager, reports to Vikram Singh
(7, 'Neha Patil', 4, 1, 140000.00), -- VP Finance, reports to Rajesh Kumar
(8, 'Rohit Verma', 4, 7, 90000.00), -- Finance Analyst, reports to Neha Patil
(9, 'Kavita Joshi', 2, 3, 125000.00), -- Developer IT, reports to Anita Desai
(10, 'Manish Kulkarni', 5, 1, 145000.00), -- VP Marketing, reports to Rajesh Kumar
(11, 'Nidhi Agarwal', 5, 10, 95000.00), -- Marketing Manager, reports to Manish Kulkarni (12, 'Suresh Iyer', 4, 7, 85000.00), -- Accountant, reports to Neha Patil
(13, 'Ravi Menon', 6, 1, 135000.00), -- VP Operations, reports to Rajesh Kumar
(14, 'Anjali Sinha', 6, 13, 105000.00), -- Operations Manager, reports to Ravi Menon
(15, 'Tarun Mehta', 2, 2, 115000.00), -- IT Support, reports to Sonal Gupta
(16, 'Deepika Rao', 3, 4, 98000.00), -- HR Assistant, reports to Vikram Singh
(17, 'Karan Chawla', 5, 10, 92000.00), -- Marketing Analyst, reports to Manish Kulkarni
(18, 'Meena Kapoor', 4, 7, 102000.00), -- Finance Manager, reports to Neha Patil
(19, 'Sanjay Reddy', 6, 13, 108000.00), -- Logistics Coordinator, reports to Ravi Menon
(20, 'Shweta Tiwari', 2, 3, 127000.00); -- Developer IT, reports to Anita Desai


CREATE TABLE courses1 (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(100),
	prerequisite_id INT,
	duration_weeks INT
);
INSERT INTO courses1 (course_id, course_name, prerequisite_id, duration_weeks) VALUES
(1, 'Intro to Programming', NULL, 10),
(2, 'Data Structures', 1, 8),
(3, 'Algorithms', 2, 10),
(4, 'Operating Systems', 2, 12),
(5, 'Databases', 1, 8);


CREATE TABLE employees2 (
	emp_id INT PRIMARY KEY,
	name VARCHAR(50),
	salary DECIMAL(10, 2)
);

INSERT INTO employees2 (emp_id, name, salary) VALUES
(1, 'Amit', 60000.00),
(2, 'Sneha', 75000.00),
(3, 'Raj', 50000.00),
(4, 'Priya', 80000.00),
(5, 'Vijay', 45000.00);

CREATE TABLE employees3 (
	emp_id INT PRIMARY KEY,
	name VARCHAR(50),
	salary DECIMAL(10, 2),
	department_id INT
);

INSERT INTO employees3 (emp_id, name, salary, department_id) VALUES
(1, 'Amit', 60000.00, 1),
(2, 'Sneha', 75000.00, 2),
(3, 'Raj', 50000.00, 1),
(4, 'Priya', 80000.00, 2),
(5, 'Vijay', 45000.00, 1),
(6, 'Anita', 70000.00, 3),
(7, 'Sunil', 65000.00, 3),
(8, 'Pooja', 55000.00, 2);



CREATE TABLE Employees4 (
	EmployeeID INT PRIMARY KEY,
	EmployeeName VARCHAR(100),
	ManagerID INT
);

INSERT INTO Employees4 (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'John', NULL), -- John is the CEO
(2, 'Alice', 1), -- Alice reports to John
(3, 'Bob', 1), -- Bob reports to John
(4, 'Charlie', 2), -- Charlie reports to Alice
(5, 'David', 2), -- David reports to Alice
(6, 'Eva', 3); -- Eva reports to Bob



CREATE TABLE employees5 (
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(50),
	department VARCHAR(50),
	salary DECIMAL(10, 2),
	hire_date DATE
);

INSERT INTO employees5 (employee_id, employee_name, department, salary, hire_date)
VALUES
(1, 'Amit', 'HR', 50000, '2022-01-15'),
(2, 'Neha', 'HR', 55000, '2023-03-10'),
(3, 'Suresh', 'HR', 48000, '2021-11-20'),
(4, 'Rohit', 'HR', 52000, '2022-09-05'),
(5, 'Raj', 'Finance', 60000, '2021-07-23'),
(6, 'Ravi', 'Finance', 62000, '2022-09-01'),
(7, 'Kiran', 'Finance', 58000, '2021-02-14'),
(8, 'Sunita', 'Finance', 61000, '2023-01-11'),
(9, 'Priya', 'IT', 70000, '2020-12-02'),
(10, 'Anjali', 'IT', 67000, '2021-11-19'),
(11, 'Vikas', 'IT', 69000, '2022-05-20'),
(12, 'Sanjay', 'IT', 72000, '2023-04-30'),
(13, 'Meena', 'IT', 68000, '2021-03-15');


CREATE TABLE employees6 (
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(50),
	department VARCHAR(50),
	city VARCHAR(50),
	salary DECIMAL(10, 2),
	hire_date DATE
);

-- inserts with few duplicate salaries
INSERT INTO employees6 (employee_id, employee_name, department, city, salary, hire_date)
VALUES
(1, 'Amit', 'HR', 'Mumbai', 50000, '2022-01-15'),
(2, 'Neha', 'HR', 'Mumbai', 55000, '2023-03-10'),
(3, 'Suresh', 'HR', 'Delhi', 48000, '2021-11-20'),
(4, 'Rohit', 'HR', 'Delhi', 52000, '2022-09-05'),
(5, 'Raj', 'Finance', 'Mumbai', 60000, '2021-07-23'),
(6, 'Ravi', 'Finance', 'Delhi', 60000, '2022-09-01'),
(7, 'Kiran', 'Finance', 'Mumbai', 58000, '2021-02-14'),
(8, 'Sunita', 'Finance', 'Delhi', 60000, '2023-01-11'),
(9, 'Priya', 'IT', 'Mumbai', 70000, '2020-12-02'),
(10, 'Anjali', 'IT', 'Delhi', 68000, '2021-11-19'),
(11, 'Vikas', 'IT', 'Mumbai', 68000, '2022-05-20'),
(12, 'Sanjay', 'IT', 'Delhi', 72000, '2023-04-30'),
(13, 'Meena', 'IT', 'Delhi', 68000, '2021-03-15');













