CREATE TABLE _3_employee_resources (
	name varchar(20),
	address varchar(20),
	email varchar(20),
	floor int,
	resources varchar(20)
);

INSERT INTO "_3_employee_resources" 
VALUES 
('A', 'Bangalore', 'A@gmail.com', 1, 'CPU'),
('A', 'Bangalore', 'A1@gmail.com', 1, 'CPU'),
('A', 'Bangalore', 'A2@gmail.com', 2, 'DESKTOP'),
('B', 'Bangalore', 'B@gmail.com', 2, 'DESKTOP'),
('B', 'Bangalore', 'B1@gmail.com', 2, 'DESKTOP'),
('B', 'Bangalore', 'B2@gmail.com', 1, 'MONITOR');

SELECT * FROM "_3_employee_resources" er;

WITH total_visit AS (
	SELECT 
	 	er.name,
		count(1) AS total_visit,
		string_agg(DISTINCT er.resources, ',') AS resources_used
	FROM "_3_employee_resources" er
	GROUP BY er.name 
),
floor_visit AS (
	SELECT 
		er.name,
		er.floor, 
		count(1) AS floor_visit_frequency,
		rank() OVER (PARTITION BY er.name ORDER BY count(1) DESC) AS floor_visit_rank
	FROM "_3_employee_resources" er
	GROUP BY er.name, er.floor
)
SELECT 
	tv.name,
	tv.total_visit,
	fv.floor AS most_visited_floor ,
	tv.resources_used
FROM total_visit tv 
JOIN floor_visit fv
ON tv.name = fv.name
WHERE fv.floor_visit_rank = 1
ORDER BY tv.name;
	 