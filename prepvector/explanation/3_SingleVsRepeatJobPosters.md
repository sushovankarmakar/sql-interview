## Input Data

```sql
-- Job Postings Table Structure
CREATE TABLE job_postings (
    id INT PRIMARY KEY,
    user_id INT,
    job_id INT,
    posted_date TIMESTAMP
);
```
|id|user_id|job_id|posted_date|
|--|-------|------|-----------|
|1|1|101|2024-01-01 |
|2|1|102|2024-01-02 |
|3|2|201|2024-01-01 |
|4|2|201|2024-01-15 |
|5|2|202|2024-01-03 |
|6|3|301|2024-01-01 |
|7|4|401|2024-01-01 |
|8|4|401|2024-01-15 |
|9|4|402|2024-01-02 |
|10|4|402|2024-01-16 |
|11|5|501|2024-01-05 |
|12|5|502|2024-01-10 |

### Question 
	Write a query to retrieve
	1. the number of users that have posted each job only once and 
	2. the number of users that have posted at least one job multiple times.

## Steps
### Step 1: Group Jobs by Posting Count
```sql
WITH job_post_counts AS (
    SELECT job_id, count(*) as posting_count
    FROM job_postings
    GROUP BY job_id
)
```
This step:
* Groups jobs by job_id
* Counts how many times each job was posted

|job_id|posting_count|
|------|-------------|
|501|1|
|201|2|
|502|1|
|301|1|
|202|1|
|101|1|
|402|2|
|401|2|
|102|1|


### Step 2: Calculate User Categories
```sql
SELECT 
    SUM(CASE WHEN jpc.posting_count = 1 THEN 1 ELSE 0 END) AS single_post_users,
    SUM(CASE WHEN jpc.posting_count > 1 THEN 1 ELSE 0 END) AS repeat_post_users
FROM job_post_counts jpc;
```
This step:
* Categorizes jobs into single posts vs repeat posts
* Uses CASE statements to count each category

### Step 3: Final step
```sql
WITH job_post_counts AS (
	SELECT job_id, count(*) as posting_count
	FROM job_postings
	GROUP BY job_id
)
SELECT 
	SUM(CASE WHEN jpc.posting_count = 1 THEN 1 ELSE 0 END) AS single_post_users,
	SUM(CASE WHEN jpc.posting_count > 1 THEN 1 ELSE 0 END) AS single_post_users
FROM job_post_counts jpc;
```
## Output
|single_post_users|single_post_users|
|-----------------|-----------------|
|6|3|


## Explanation
### 1. Table Structure:
* `job_postings`: Tracks job posting history
* Primary key on `id`
* References `user_id` and `job_id`
* Includes timestamp for posting date

### 2. Problem Requirements:
* Count users who post jobs only once
* Count users who post jobs multiple times
* Each user should be counted in only one category

### 3. Solution Approach:
* <p style="color:red">First group by job_id to count postings</p>
* Use CASE statements to categorize users
* Calculate totals for each category

### 4. Key Concepts Used:
* Common Table Expressions (CTE)
* Window Functions
* GROUP BY clause
* Aggregate functions (COUNT, SUM)
* CASE statements
* DISTINCT to avoid duplicates

### 5. Performance Considerations:
```sql
CREATE INDEX idx_job_postings_user_job 
ON job_postings(user_id, job_id);
```
* Add index on frequently queried columns
* Use window functions for better performance
* Minimize table scans