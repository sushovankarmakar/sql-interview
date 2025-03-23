*[Complex SQL 3 | Scenario based Interviews Question for Product companies](https://www.youtube.com/watch?v=P6kNMyqKD0A&ab_channel=AnkitBansal)*

## Input data
```sql
SELECT * FROM "_3_employee_resources" er;
```

|name|address|email|floor|resources|
|----|-------|-----|-----|---------|
|A|Bangalore|A@gmail.com|1|CPU|
|A|Bangalore|A1@gmail.com|1|CPU|
|A|Bangalore|A2@gmail.com|2|DESKTOP|
|B|Bangalore|B@gmail.com|2|DESKTOP|
|B|Bangalore|B1@gmail.com|2|DESKTOP|
|B|Bangalore|B2@gmail.com|1|MONITOR|


## Steps

### 1. Aggregate

Find out on employee level that 
	<ol>
		<li>the total number of visit</li>
		<li>list of resources used</li>
	</ol>

```sql
SELECT 
	er.name,
	count(1) AS total_visit,
	string_agg(DISTINCT er.resources, ',') AS resources_used
FROM "_3_employee_resources" er
GROUP BY er.name
```

|name|total_visit|resources_used|
|----|-----------|--------------|
|A|3|CPU,DESKTOP|
|B|3|DESKTOP,MONITOR|


### 2. Rank

Find at floor level that 
	<ol>
		<li>which floor was visited how many times</li>
	</ol>

```sql
SELECT 
	er.name,
	er.floor, 
	count(1) AS floor_visit_frequency,
	rank() OVER (PARTITION BY er.name ORDER BY count(1) DESC) AS floor_visit_rank
FROM "_3_employee_resources" er
GROUP BY er.name, er.floor
```

|name|floor|floor_visit_frequency|floor_visit_rank|
|----|-----|---------------------|----------------|
|A|1|2|1|
|A|2|1|2|
|B|2|2|1|
|B|1|1|2|

### 3. Join 
Join both the CTE

```sql
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
```

## Output

|name|total_visit|most_visited_floor|resources_used|
|----|-----------|------------------|--------------|
|A|3|1|CPU,DESKTOP|
|B|3|2|DESKTOP,MONITOR|

