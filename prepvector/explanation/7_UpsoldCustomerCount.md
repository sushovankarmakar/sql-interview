# Upsold Customer Count Analysis

## Input

```sql
SELECT * FROM transactions1 t ;
```
|id|user_id|created_at|product_id|quantity|
|--|-------|----------|----------|--------|
|1|101|2024-01-01 10:00:00|1|1|
|2|101|2024-01-01 14:00:00|2|1|
|3|101|2024-01-15 09:00:00|3|1|
|4|102|2024-01-05 11:00:00|1|2|
|5|102|2024-01-05 11:30:00|2|1|
|6|103|2024-01-02 15:00:00|1|1|
|7|104|2024-01-01 09:00:00|1|1|
|8|104|2024-01-02 10:00:00|2|1|
|9|104|2024-01-03 11:00:00|3|1|

## Question
#### Write a query to get the number of customers that were upsold by purchasing additional products.

_Note: If a customer purchased multiple products on the same day, it does not count as an upsell. 
An upsell is considered only if they made purchases on separate days_

### Step 1 : Count Distinct Purchase Days
```sql
WITH user_date_count AS (
  SELECT 
    t.user_id,
    COUNT(DISTINCT DATE(t.created_at)) AS date_count
  FROM transactions1 t
  GROUP BY t.user_id
)
```
|user_id|date_count|
|-------|----------|
|101|2|
|102|1|
|103|1|
|104|3|

* This step counts how many different days each user made purchases.

### Step 2 : Filter Upsold Customers
```sql
WITH user_date_count AS (
  -- Step 1 query here
)
SELECT count(user_id) AS upsold_customer_count
FROM user_date_count udc
WHERE udc.date_count > 1;
```
---

## Final query
```sql
WITH user_date_count AS (
  SELECT 
    t.user_id,
    COUNT(DISTINCT DATE(t.created_at)) AS date_count
  FROM transactions1 t
  GROUP BY t.user_id
)
SELECT count(user_id) AS upsold_customer_count
FROM user_date_count udc
WHERE udc.date_count > 1;
```
## Ouptut
|upsold_customer_count|
|---------------------|
|2|

## Explanation

1. **Table Structure**:
   - transactions1: Stores customer purchase history
   - Includes: transaction ID, user ID, timestamp, product details

2. **Problem Requirements**:
   - Count customers with purchases on different days
   - Exclude same-day multiple purchases
   - Consider only distinct date purchases

3. **Solution Approach**:
   - Group transactions by user
   - Count distinct purchase dates
   - Filter users with multiple dates

4. **Key Concepts Used**:
   - DISTINCT for unique dates
   - DATE() for timestamp conversion
   - CTEs for readability
   - COUNT aggregation

