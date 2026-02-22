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




















