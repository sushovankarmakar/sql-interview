*[Finding Cancellation Rate in Trip Data](https://www.youtube.com/watch?v=EjzhMv0E_FE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=7&ab_channel=AnkitBansal)*

## Input data
```sql
-- Trips table
SELECT * FROM "_7_trips" t;
```
|id|client_id|driver_id|city_id|status|request_at|
|--|---------|---------|-------|------|----------|
|1|1|10|1|completed|2013-10-01|
|2|2|11|1|cancelled_by_driver|2013-10-01|
|3|3|12|6|completed|2013-10-01|
|4|4|13|6|cancelled_by_client|2013-10-01|
|5|1|10|1|completed|2013-10-02|
|6|2|11|6|completed|2013-10-02|
|7|3|12|6|completed|2013-10-02|
|8|2|12|12|completed|2013-10-03|
|9|3|10|12|completed|2013-10-03|
|10|4|13|12|cancelled_by_driver|2013-10-03|


```sql
-- Users table
SELECT * FROM "_7_users" u;
```

|users_id|banned|role|
|--------|------|----|
|1|No|client|
|2|Yes|client|
|3|No|client|
|4|No|client|
|10|No|driver|
|11|No|driver|
|12|No|driver|
|13|No|driver|


---
## Steps

### Step1: Filter Valid Trips
```sql
WITH valid_trips AS (
    SELECT t.*
    FROM "_7_trips" t 
    JOIN "_7_users" client 
        ON client.users_id = t.client_id 
        AND client.banned = 'No'
    JOIN "_7_users" driver 
        ON driver.users_id = t.driver_id 
        AND driver.banned = 'No'
)
```
- Join trips with users table twice (for both client and driver)
- Filter out trips where either client or driver is banned
- Keep all columns from trips table for valid records

|id|client_id|driver_id|city_id|status|request_at|users_id|banned|role|users_id|banned|role|
|--|---------|---------|-------|------|----------|--------|------|----|--------|------|----|
|1|1|10|1|completed|2013-10-01|1|No|client|10|No|driver|
|3|3|12|6|completed|2013-10-01|3|No|client|12|No|driver|
|4|4|13|6|cancelled_by_client|2013-10-01|4|No|client|13|No|driver|
|5|1|10|1|completed|2013-10-02|1|No|client|10|No|driver|
|7|3|12|6|completed|2013-10-02|3|No|client|12|No|driver|
|9|3|10|12|completed|2013-10-03|3|No|client|10|No|driver|
|10|4|13|12|cancelled_by_driver|2013-10-03|4|No|client|13|No|driver|


### Step2: Calculate Daily Statistics
```sql
WITH daily_stats AS (
    SELECT 
        request_at,
        COUNT(*) AS total_trips,
        COUNT(CASE 
            WHEN status IN ('cancelled_by_client', 'cancelled_by_driver') 
            THEN 1 
        END) AS cancelled_trips
    FROM valid_trips
    GROUP BY request_at
)
```
- Group trips by request date
- Count total trips per day
- Count cancelled trips per day using CASE expression

|request_at|cancelled_trips|total_trips|
|----------|---------------------|-----------|
|2013-10-01|1|3|
|2013-10-02|0|2|
|2013-10-03|1|2|


### Step3: Calculate Cancellation Rates
```sql
SELECT 
    request_at,
    ROUND(
        CASE 
            WHEN total_trips = 0 THEN 0
            ELSE (cancelled_trips * 100.0 / total_trips)
        END
    , 2) AS cancellation_percent
FROM daily_stats
ORDER BY request_at;
```
- Calculate percentage of cancelled trips
- Handle division by zero using CASE
- Round result to 2 decimal places
- Order results by date

## Output
|request_at|cancellation_percent|
|----------|--------------------|
|2013-10-01|33.33|
|2013-10-02|0.00|
|2013-10-03|50.00|


Key Points:
1. We need two JOINs because we check both client and driver ban status
2. Cancellation includes both client and driver cancellations
3. Percentage is calculated per day
4. Results are rounded to 2 decimal places

## Memory Techniques & Tips

1. **JOIN Structure (Think C-D-T)**:
   - **C**lient JOIN first
   - **D**river JOIN second
   - **T**rips table is base

2. **Status Check (Think NOT)**:
   - Instead of checking cancelled statuses
   - Use `status != 'completed'`
   - Easier to remember one condition

3. **Percentage Formula (Think 100.0)**:
   - Always multiply by 100.0 (not 100)
   - Decimal point ensures floating division
   ```sql
   cancelled * 100.0 / total
   ```

4. **Visual Flow (Think F-C-R)**:
   - **F**ilter (valid trips)
   - **C**ount (daily stats)
   - **R**ate (percentage)

5. **Key Points to Remember**:
   - Double JOIN for double check (client & driver)
   - Daily grouping comes before rate calculation
   - Always handle division by zero (use COALESCE)
   - Round at the very end (not during calculation)

6. **Common Pitfalls**:
   - Forgetting to check both users
   - Missing the floating point division
   - Not handling zero division cases
   - Rounding too early in calculation

This problem tests understanding of:
- JOIN operations
- Aggregation functions
- Percentage calculations
- NULL handling
- Date grouping