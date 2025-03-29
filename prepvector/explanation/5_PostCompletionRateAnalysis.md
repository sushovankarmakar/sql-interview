
## Input

```sql
SELECT * FROM post_events;
```
|user_id|created_at|action|
|-------|----------|------|
|1|2020-01-01 10:00:00.000|post_enter|
|1|2020-01-01 10:05:00.000|post_submit|
|2|2020-01-01 11:00:00.000|post_enter|
|2|2020-01-01 11:10:00.000|post_canceled|
|3|2020-01-01 15:00:00.000|post_enter|
|3|2020-01-01 15:30:00.000|post_submit|
|4|2020-01-02 09:00:00.000|post_enter|
|4|2020-01-02 09:15:00.000|post_canceled|
|5|2020-01-02 10:00:00.000|post_enter|
|5|2020-01-02 10:10:00.000|post_canceled|
|10|2020-01-15 14:00:00.000|post_enter|
|10|2020-01-15 14:30:00.000|post_submit|
|6|2019-12-31 23:55:00.000|post_enter|
|6|2020-01-01 00:05:00.000|post_submit|
|7|2020-02-01 00:00:00.000|post_enter|
|7|2020-02-01 00:10:00.000|post_submit|
|8|2019-01-15 10:00:00.000|post_enter|
|8|2019-01-15 10:30:00.000|post_submit|
|9|2021-01-01 09:00:00.000|post_enter|
|9|2021-01-01 09:10:00.000|post_canceled|

## Question
**Write a query to get the post-success rate for each day in the month of January 2020** <br>
* Post Success Rate is defined as the number of posts submitted (post_submit) divided by the number of posts entered (post_enter) for each day

### 1. My first solution
```sql
WITH jan_posts AS (
	SELECT *, DATE(created_at) AS date 
	FROM post_events
	WHERE created_at LIKE '2020-01-%'
) ,
post_count AS (
	SELECT DISTINCT date,
	COUNT(CASE WHEN action = 'post_enter' THEN 1 ELSE NULL END) OVER (PARTITION BY date) AS total_enters,
	COUNT(CASE WHEN action = 'post_submit' THEN 1 ELSE NULL END) OVER (PARTITION BY date) AS total_submits 
	FROM jan_posts
)
SELECT 
	date,
	total_enters,
	total_submits,
	total_submits / NULLIF(total_enters, 0) AS success_rate
FROM post_count;
```
---

### 2. Improved solution 
####  improved version of the SQL query with better performance and readability

#### 1. Better Date Filtering:
* **Replaced LIKE '2020-01-%' with proper date range**
* More efficient for index usage
* Clearer intent

#### 2. Simplified Aggregation:
* **Used SUM with GROUP BY instead of window functions**
* **Removed unnecessary DISTINCT**
* Single pass through data

## Steps

### Step 1 : Filter January 2020 Events
```sql
SELECT 
    DATE(created_at) AS post_date,
    action
FROM post_events
WHERE created_at >= '2020-01-01' 
AND created_at < '2020-02-01';
```
This step filters events within January 2020 using proper date range.
|post_date|action|
|---------|------|
|2020-01-01|post_enter|
|2020-01-01|post_submit|
|2020-01-01|post_enter|
|2020-01-01|post_canceled|
|2020-01-01|post_enter|
|2020-01-01|post_submit|
|2020-01-02|post_enter|
|2020-01-02|post_canceled|
|2020-01-02|post_enter|
|2020-01-02|post_canceled|
|2020-01-15|post_enter|
|2020-01-15|post_submit|
|2020-01-01|post_submit|


### Step 2 : Calculate Daily Totals
```sql
SELECT 
    DATE(created_at) AS post_date,
    SUM(CASE WHEN action = 'post_enter' THEN 1 ELSE 0 END) AS total_enters,
    SUM(CASE WHEN action = 'post_submit' THEN 1 ELSE 0 END) AS total_submits
FROM post_events
WHERE created_at >= '2020-01-01' 
AND created_at < '2020-02-01'
GROUP BY DATE(created_at);
```
This aggregates daily enter and submit counts.

|post_date|total_enters|total_submits|
|---------|------------|-------------|
|2020-01-01|3|3|
|2020-01-02|2|0|
|2020-01-15|1|1|


### Step 3: Calculate Success Rate
```sql
WITH daily_stats AS (
    -- Step 2 query here
)
SELECT 
    post_date,
    total_enters,
    total_submits,
    ROUND(
        CAST(total_submits AS DECIMAL) / NULLIF(total_enters, 0), 
        2
    ) AS success_rate
FROM daily_stats
ORDER BY post_date;
```
---

### Final query 
```sql
WITH daily_stats AS (
    SELECT 
        DATE(created_at) AS post_date,
        SUM(CASE WHEN action = 'post_enter' THEN 1 ELSE 0 END) AS total_enters,
        SUM(CASE WHEN action = 'post_submit' THEN 1 ELSE 0 END) AS total_submits
    FROM events
    WHERE created_at >= '2020-01-01' 
    AND created_at < '2020-02-01'
    GROUP BY DATE(created_at)
)
SELECT 
    post_date,
    total_enters,
    total_submits,
    ROUND(
        CAST(total_submits AS DECIMAL) / NULLIF(total_enters, 0), 
        2
    ) AS success_rate
FROM daily_stats
ORDER BY post_date;
```
|date|total_enters|total_submits|success_rate|
|----|------------|-------------|------------|
|2020-01-01|3|3|1.00|
|2020-01-02|2|0|0.00|
|2020-01-15|1|1|1.00|



## Explanation
#### Table Structure:
* post_events: Tracks user post actions
* Contains user_id, timestamp, and action type
* Actions include: post_enter, post_submit, post_canceled

#### Problem Requirements:
* Calculate daily success rate for January 2020
* Success rate = submitted posts / entered posts
* Round to 2 decimal places
* Handle division by zero cases

#### Solution Approach:
* Filter relevant time period
* Count daily enters and submits
* Calculate ratio with proper type casting
* Order results chronologically

#### Key Concepts Used:
* Date filtering and extraction
* Conditional aggregation (SUM with CASE)
* NULL handling (NULLIF)
*  Type casting for decimal division
* CTEs for readability

#### Performance Optimization:
```sql
CREATE INDEX idx_post_events_date 
ON post_events(created_at, action);
```