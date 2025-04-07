# Click through rate by age

## Input :

```sql
SELECT * FROM users2;
```

|id|name|birthdate|
|--|----|---------|
|1|Alice|1995-05-15 00:00:00|
|2|Bob|1985-03-20 00:00:00|
|3|Charlie|2005-07-10 00:00:00|
|4|David|1955-11-30 00:00:00|
|5|Eve|2015-09-25 00:00:00|
|6|Frank|1935-02-14 00:00:00|
|7|Grace|1975-12-01 00:00:00|

```sql
SELECT * FROM search_events;
```

|search_id|query|has_clicked|user_id|search_time|
|---------|-----|-----------|-------|-----------|
|1|travel|true|1|2021-03-15 10:00:00|
|2|books|false|1|2021-03-15 11:00:00|
|3|cars|true|2|2021-05-20 14:30:00|
|4|tech|true|2|2021-05-20 15:00:00|
|5|games|false|3|2021-07-10 16:45:00|
|6|music|false|3|2021-07-10 17:00:00|
|7|retirement|true|4|2021-09-05 09:15:00|
|8|health|false|4|2021-09-05 10:00:00|
|9|toys|false|5|2021-11-25 13:20:00|
|10|genealogy|true|6|2021-12-01 11:30:00|
|11|history|true|6|2021-12-01 12:00:00|
|12|finance|true|7|2021-02-15 08:45:00|
|13|investing|false|7|2021-02-15 09:00:00|

## Question 
Find the three age groups with highest click-through rates in 2021, with older groups taking priority in ties.


### Step 1: Age Details CTE
First, calculate age of users at the time of search:

```sql
WITH age_details AS (
    SELECT
        se.search_id,
        se.has_clicked,
        EXTRACT(YEAR FROM age(se.search_time, u.birthdate)) AS age
    FROM users2 u 
    JOIN search_events se ON u.id = se.user_id
    WHERE EXTRACT(YEAR FROM se.search_time) = 2021
)
```
Sample output:

search_id | has_clicked | age
----------|-------------|-----
1         | true        | 26    &nbsp; &nbsp; &nbsp; -- *Alice*
2         | false       | 26    &nbsp; &nbsp; &nbsp; -- *Alice*
3         | true        | 36    &nbsp; &nbsp; &nbsp; -- *Bob*
4         | true        | 36    &nbsp; &nbsp; &nbsp; -- *Bob*

### Step 2: Age Group Details CTE
Next, bucket ages into decades:

```sql
age_group_details AS (
    SELECT 
        has_clicked,
        CASE
            WHEN age >= 0 AND age <= 9 THEN '0-9'
            WHEN age >= 10 AND age <= 19 THEN '10-19'
            -- ...other decades...
            WHEN age >= 90 AND age <= 99 THEN '90-99'
        END AS age_group
    FROM age_details
    WHERE age BETWEEN 0 AND 99
)
```

Sample output:

has_clicked | age_group
------------|----------
true        | 20-29    &nbsp; &nbsp; &nbsp; -- *Alice's searches*
false       | 20-29    &nbsp; &nbsp; &nbsp; -- *Alice's searches*
true        | 30-39    &nbsp; &nbsp; &nbsp; -- *Bob's searches*
true        | 30-39    &nbsp; &nbsp; &nbsp; -- *Bob's searches*

### Step 3: Click Metrics CTE

Calculate total searches and clicks per age group:

```sql
click_metrics AS (
    SELECT 
        age_group,
        COUNT(*) AS total_searches,
        SUM(CASE WHEN has_clicked THEN 1 ELSE 0 END) AS clicks
    FROM age_group_details
    GROUP BY age_group
)
```

Sample output:
age_group | total_searches | clicks
----------|----------------|--------
20-29     | 2             | 1      &nbsp; &nbsp; &nbsp; -- *50% CTR*
30-39     | 2             | 2      &nbsp; &nbsp; &nbsp; -- *100% CTR*
60-69     | 2             | 2      &nbsp; &nbsp; &nbsp; -- *100% CTR*


### Step 4: Final CTR Calculation

```sql
SELECT 
    age_group,
    ROUND(COALESCE(clicks * 100.0 / NULLIF(total_searches, 0), 0), 2) AS ctr
FROM click_metrics 
ORDER BY 
    ctr DESC,        -- Highest CTR first
    age_group DESC   -- Older age groups win ties
LIMIT 3;
```

Final output:
age_group | ctr
----------|-------
60-69     | 100.00  &nbsp; &nbsp; &nbsp; -- *Older group wins tie*
30-39     | 100.00  &nbsp; &nbsp; &nbsp; -- *Same CTR as above*
20-29     | 50.00   &nbsp; &nbsp; &nbsp; -- *Lower CTR*


The `COALESCE` and `NULLIF` combination handles division by zero cases by returning 0 instead of error.

```sql
ROUND(COALESCE(clicks * 100.0 / NULLIF(total_searches, 0), 0), 2) AS ctr
```
1. First, `NULLIF(total_searches, 0)` prevents division by zero:
```
total_searches = 0 → NULLIF returns NULL
total_searches ≠ 0 → NULLIF returns original value
```
2. Then, `COALESCE` handles the NULL cases:
```
If (clicks * 100.0 / NULLIF(total_searches, 0)) is NULL → return 0
If not NULL → return the calculated percentage
```

```
Scenario 1: Normal case
- clicks = 5
- total_searches = 10
→ (5 * 100.0 / 10) = 50.00%

Scenario 2: No searches (division by zero)
- clicks = 0
- total_searches = 0
→ NULLIF(0, 0) = NULL
→ (0 * 100.0 / NULL) = NULL
→ COALESCE(NULL, 0) = 0.00%
```

### The whole solution
```sql
WITH age_details AS (
    SELECT
        se.search_id,
        se.has_clicked,
        EXTRACT(YEAR FROM age(se.search_time, u.birthdate)) AS age
    FROM users2 u 
    JOIN search_events se ON u.id = se.user_id
    WHERE EXTRACT(YEAR FROM se.search_time) = 2021  -- Add year filter
),
age_group_details AS (
    SELECT 
        CASE
            WHEN age >= 0 AND age <= 9 THEN '0-9'
            WHEN age >= 10 AND age <= 19 THEN '10-19'
            WHEN age >= 20 AND age <= 29 THEN '20-29'
            WHEN age >= 30 AND age <= 39 THEN '30-39'
            WHEN age >= 40 AND age <= 49 THEN '40-49'
            WHEN age >= 50 AND age <= 59 THEN '50-59'
            WHEN age >= 60 AND age <= 69 THEN '60-69'
            WHEN age >= 70 AND age <= 79 THEN '70-79'
            WHEN age >= 80 AND age <= 89 THEN '80-89'
            WHEN age >= 90 AND age <= 99 THEN '90-99'
        END AS age_group,
        has_clicked
    FROM age_details
    WHERE age BETWEEN 0 AND 99  -- Add age range filter
),
click_metrics AS (
    SELECT 
        age_group,
        COUNT(*) AS total_searches,
        SUM(CASE WHEN has_clicked THEN 1 ELSE 0 END) AS clicks
    FROM age_group_details
    GROUP BY age_group
)
SELECT 
    age_group,
    ROUND(COALESCE(clicks * 100.0 / NULLIF(total_searches, 0), 0), 2) AS ctr
FROM click_metrics 
WHERE age_group IS NOT NULL  -- Exclude null age groups
ORDER BY 
    ctr DESC,
    age_group DESC  -- Older age groups get priority for ties
LIMIT 3;
```