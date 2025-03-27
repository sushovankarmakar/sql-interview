
## Input

```sql
SELECT * FROM customer_sales cs ;
```

|id|transaction_value|created_at|
|--|-----------------|----------|
|1|50.00|2025-01-23 10:15:00.000|
|2|30.00|2025-01-23 15:45:00.000|
|3|20.00|2025-01-23 18:30:00.000|
|4|45.00|2025-01-24 09:20:00.000|
|5|60.00|2025-01-24 22:10:00.000|
|6|25.00|2025-01-25 11:30:00.000|
|7|35.00|2025-01-25 14:50:00.000|
|8|55.00|2025-01-25 19:05:00.000|

## Question
##
**Write a query to get the last transaction for each day.**
<br>
The output should include the ID of the transaction, datetime of the transaction, and the transaction amount. 
<br>
Order the transactions by datetime.
##

## Steps

### Step 1: Partition Data by Date
```sql
SELECT 
	cs.id,
	cs.transaction_value,
	cs.created_at,
	row_number() OVER (
		PARTITION BY DATE(cs.created_at)
		ORDER BY created_at DESC
	) AS rn
FROM customer_sales cs ;
```
|id|transaction_value|created_at|rn|
|--|-----------------|----------|--|
|3|20.00|2025-01-23 18:30:00.000|1|
|2|30.00|2025-01-23 15:45:00.000|2|
|1|50.00|2025-01-23 10:15:00.000|3|
|5|60.00|2025-01-24 22:10:00.000|1|
|4|45.00|2025-01-24 09:20:00.000|2|
|8|55.00|2025-01-25 19:05:00.000|1|
|7|35.00|2025-01-25 14:50:00.000|2|
|6|25.00|2025-01-25 11:30:00.000|3|

* This step extracts the date part for grouping transactions.

---

### Step 2: Apply Window Function and Get Final Results
```sql
WITH latest_transactions AS (
	SELECT 
		cs.id,
		cs.transaction_value,
		cs.created_at,
		row_number() OVER (
			PARTITION BY DATE(cs.created_at)
			ORDER BY created_at DESC
		) AS rn
	FROM customer_sales cs 
)
SELECT 
	lt.id,
	lt.created_at,
	lt.transaction_value
FROM latest_transactions lt
WHERE lt.rn = 1
ORDER BY lt.created_at;
```
## Output
|id|created_at|transaction_value|
|--|----------|-----------------|
|3|2025-01-23 18:30:00.000|20.00|
|5|2025-01-24 22:10:00.000|60.00|
|8|2025-01-25 19:05:00.000|55.00|

* This assigns row numbers within each date partition.
---

### Improvements made:
#### 1. Used ROW_NUMBER() instead of MAX() window function
* More efficient for finding last record per group
* Considers actual timestamp, not just ID

#### 2. Removed unnecessary columns
* No need to select all columns with *
* Only selected required output fields

#### 3. Better organization with CTE
* More readable code structure
* Easier to maintain and modify

#### 4. Added explicit ordering
* ORDER BY created_at DESC in window function
* Final ORDER BY created_at for result display

#### 5. Performance optimization:
```sql
CREATE INDEX idx_customer_sales_date 
ON customer_sales(created_at);
```
This will give you the correct last transaction per day based on actual timestamp rather than just the ID.



## Explanation
### 1. Table Structure:
* `customer_sales`: Tracks daily transactions
* Contains ID, amount, and timestamp
* Primary key on `id` column

### 2. Problem Requirements:
* Find last transaction for each day
* Include transaction ID, time, and amount
* Order results chronologically

### 3. Solution Approach:
* Group transactions by date
* Use `ROW_NUMBER()` for ranking
* Filter for rank = 1
* Order results by timestamp

### 4. Key Concepts Used:
* Window Functions (ROW_NUMBER)
* CTEs for readability
* DATE() function for grouping
* PARTITION BY clause
* ORDER BY for sorting

### 5. Time Complexity:
* `O(n log n)` due to window function sorting
* Improved by index on created_at