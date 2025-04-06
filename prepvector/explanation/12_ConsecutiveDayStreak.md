
# Consecutive day streak

### Sample input data

|user_id|created_at|url|
|-------|----------|---|
|1|2020-01-08 12:00:00|https://example.com/page8|
|1|2020-01-09 12:00:00|https://example.com/page9|
|1|2020-01-10 12:00:00|https://example.com/page10|
|2|2020-02-10 15:00:00|https://example.com/dashboard|
|2|2020-02-11 16:00:00|https://example.com/profile|
|2|2020-02-12 17:00:00|https://example.com/settings|

---

Given a table with event logs, <br>
find the top five users with the `longest continuous streak` of visiting the platform in 2020. <br>
A continuous streak counts if the user visits the platform at least once per day on consecutive days. <br>

---

### Step 1: Daily Visits CTE
First, we get unique daily visits per user in 2020:

```sql
WITH daily_visits AS (
    SELECT DISTINCT 
        user_id,
        DATE(created_at) as visit_date
    FROM user_events
    WHERE created_at >= '2020-01-01'
    AND created_at < '2021-01-01'
)
```
Sample output:

user_id | visit_date
--------|------------
1       | 2020-01-01
1       | 2020-01-02
1       | 2020-01-04
1       | 2020-01-05

---

### Step 2: Streak Breaks CTE
Next, we identify where streaks break using LAG to compare consecutive dates:

```sql
streak_breaks AS (
    SELECT 
        user_id,
        visit_date,
        LAG(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date) AS prev_day,
        CASE 
            WHEN DATE(visit_date) - DATE(LAG(visit_date) OVER (
                PARTITION BY user_id ORDER BY visit_date
            )) = 1 THEN 0
            ELSE 1
        END as is_new_streak
    FROM daily_visits
)
```
Sample output:

user_id | visit_date  | prev_day    | is_new_streak
--------|-------------|-------------|---------------
1       | 2020-01-01 | NULL        | 1
1       | 2020-01-02 | 2020-01-01  | 0
1       | 2020-01-04 | 2020-01-02  | 1  &nbsp; &nbsp; &nbsp; &nbsp; `// Break here (gap)`
1       | 2020-01-05 | 2020-01-04  | 0

---

### Step 3: Streak Groups CTE
Then, we number each streak using **running sum** of breaks:

```sql
streak_groups AS (
    SELECT *,
        SUM(sb.is_new_streak) OVER (
            PARTITION BY user_id ORDER BY sb.visit_date
        ) AS streak_number
    FROM streak_breaks sb
)
```
Sample output:

user_id | visit_date  | prev_day    | is_new_streak | streak_number
--------|-------------|-------------|---------------|---------------
1       | 2020-01-01 | NULL        | 1            | 1
1       | 2020-01-02 | 2020-01-01  | 0            | 1
1       | 2020-01-04 | 2020-01-02  | 1            | 2
1       | 2020-01-05 | 2020-01-04  | 0            | 2

---

### Step 4: Final Query
Finally, we count streak lengths and get top 5:

```sql
SELECT 
    sg.user_id, 
    count(*) AS streak_length
FROM streak_groups sg
    GROUP BY sg.user_id, sg.streak_number
    ORDER BY streak_length DESC
LIMIT 5;
```

Expected output:

user_id | streak_length
--------|---------------
6       | 10    &nbsp; &nbsp; &nbsp; &nbsp; `// June 1-10 continuous streak`
1       | 7     &nbsp; &nbsp; &nbsp; &nbsp; `// Jan 4-10 continuous streak`
2       | 5     &nbsp; &nbsp; &nbsp; &nbsp; `// Feb 14-18 continuous streak`
...     | ...

The longest streak is from user 6 with 10 consecutive days of visits in June 2020, which you can verify from the raw data.
