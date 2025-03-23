CREATE TABLE _7_trips (
    id int, 
    client_id int, 
    driver_id int, 
    city_id int, 
    status varchar(50), 
    request_at varchar(50)
);

CREATE TABLE _7_users (
    users_id int, 
    banned varchar(50), 
    role varchar(50)
);

INSERT INTO _7_trips (id, client_id, driver_id, city_id, status, request_at) 
VALUES
('1', '1', '10', '1', 'completed', '2013-10-01'),
('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01'),
('3', '3', '12', '6', 'completed', '2013-10-01'),
('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01'),
('5', '1', '10', '1', 'completed', '2013-10-02'),
('6', '2', '11', '6', 'completed', '2013-10-02'),
('7', '3', '12', '6', 'completed', '2013-10-02'),
('8', '2', '12', '12', 'completed', '2013-10-03'),
('9', '3', '10', '12', 'completed', '2013-10-03'),
('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');

INSERT INTO _7_users (users_id, banned, role) 
VALUES 
('1', 'No', 'client'),
('2', 'Yes', 'client'),
('3', 'No', 'client'),
('4', 'No', 'client'),
('10', 'No', 'driver'),
('11', 'No', 'driver'),
('12', 'No', 'driver'),
('13', 'No', 'driver');


SELECT * FROM "_7_trips" t;
SELECT * FROM "_7_users" u;

-- write a sql query to find the cancellation rate of requests with unbanned users
-- (both client and user must not be banned) each day between "2013-10-01" and "2013-10-03"
-- round calcellation rate to two decimal points

-- The cancellation rate is computed 
-- by dividing the number of cancelled (by client or driver) requests with unbanned users 
-- by the total number of requests with unbanned users on that day

/* I was joining tables in wrong way

SELECT * FROM "_7_trips" t 
JOIN "_7_users" u 
ON u.users_id IN (t.client_id, t.driver_id)
WHERE u.banned = 'No'
*/

-- 1. filter out banned users
SELECT * FROM "_7_trips" t 
JOIN "_7_users" u 
	ON u.users_id = t.client_id
	AND u.banned = 'No'
JOIN "_7_users" d 
	ON d.users_id = t.driver_id 
	AND d.banned = 'No'

-- 2. count total trips and cancelled trips each day
WITH trips_details AS (
	SELECT t.request_at,
		count(
			CASE 
				WHEN t.status IN ('cancelled_by_client', 'cancelled_by_driver') THEN 1
				ELSE NULL
			END
		) AS cancelled_trips_count,
		count(t.request_at) AS total_trips
	FROM "_7_trips" t 
	JOIN "_7_users" u 
		ON u.users_id = t.client_id
		AND u.banned = 'No'
	JOIN "_7_users" d 
		ON d.users_id = t.driver_id
		AND d.banned = 'No'
	GROUP BY t.request_at
)
SELECT 
	td.request_at,
	round(
		(((1.0 * td.cancelled_trips_count) / td.total_trips) * 100)
	, 2) AS cancellation_percent
FROM trips_details td
ORDER BY request_at ;



-- Below query produces the same results but is much easier to understand and maintain.
-- let's break down the solution into smaller, more understandable parts using CTEs. Here's a more readable version:

-- Step 1: Get only valid trips (with unbanned users)
WITH valid_trips AS (
    SELECT t.*
    FROM "_7_trips" t 
    JOIN "_7_users" client 
        ON client.users_id = t.client_id 
        AND client.banned = 'No'
    JOIN "_7_users" driver 
        ON driver.users_id = t.driver_id 
        AND driver.banned = 'No'
),
-- Step 2: Count daily trips and cancellations
daily_stats AS (
    SELECT 
        request_at,
        COUNT(*) AS total_trips,
        COUNT(CASE 
            WHEN status IN ('cancelled_by_client', 'cancelled_by_driver') 
            THEN 1 
        END) AS cancelled_trips
    FROM valid_trips
    GROUP BY request_at
),
-- Step 3: Calculate cancellation percentage
cancellation_rates AS (
    SELECT 
        request_at,
        CASE 
            WHEN total_trips = 0 THEN 0
            ELSE (cancelled_trips * 100.0 / total_trips)
        END AS cancel_percent
    FROM daily_stats
)
-- Final result with rounded percentages
SELECT 
    request_at,
    ROUND(cancel_percent, 2) AS cancellation_percent
FROM cancellation_rates
ORDER BY request_at;