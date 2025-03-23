-- pre-requisite : basic knowledge
SELECT EXTRACT(DOW FROM '2025-03-21'::date) AS day_number;
SELECT TO_CHAR('2025-03-21'::date, 'Day') AS day_name;

SELECT '2025-03-21'::date + INTERVAL '5 days' AS new_date;
SELECT '2025-03-21'::date + INTERVAL '1 month' AS next_month;
SELECT '2025-03-21'::date + INTERVAL '1 year' AS next_year;

-- creating custom functions

-- dateofweek 
CREATE FUNCTION dateofweek(input_date DATE) RETURNS INT AS $$
BEGIN
	RETURN EXTRACT(DOW FROM input_date);
END;
$$ LANGUAGE plpgsql;

-- dateadd
CREATE FUNCTION dateadd(input_date DATE, days_to_add INT) RETURNS DATE AS $$
BEGIN
	RETURN input_date + days_to_add;
END;
$$ LANGUAGE plpgsql;

-- get next nth sunday from a given date
CREATE FUNCTION nextNthSunday(input_date DATE, n INT) RETURNS DATE AS $$
DECLARE
	days_to_add INT;
	new_date DATE;
BEGIN
	days_to_add := (7 - dateofweek(input_date) + ((n - 1) * 7));
	new_date := dateadd(input_date, days_to_add);
	RETURN new_date;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION nextNthSunday;

SELECT dateofweek('2025-03-21');
SELECT dateadd('2025-03-21', 3);

-- Write a query to provide the date for nth occurrence of Sunday in future from given date
SELECT nextNthSunday('2025-03-21', 1); -- 1st sunday in future which is 2025-03-23 
SELECT nextNthSunday('2025-03-21', 2); -- 2nd sunday in future which is 2025-03-30 
SELECT nextNthSunday('2025-03-21', 10); -- 2nd sunday in future which is 2025-05-25










