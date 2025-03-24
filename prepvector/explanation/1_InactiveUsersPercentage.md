[Calculating Inactive Users Percentage](https://challenges.prepvector.com/challenges/fe090a86-abf5-4e46-92b4-6fc5ce069bc3/questions/04e7018e-0724-4f82-b90f-000f286da314)

### Input Data
```sql
-- Users table sample
SELECT * FROM users;
/* Results:
user_id | name
1       | John
2       | Jane
3       | Bob
4       | Alice
5       | Mike
*/

-- Events table sample
SELECT * FROM events WHERE action IN ('like', 'comment');
/* Results:
event_id | user_id | action  | created_at
4        | 2       | like    | 2024-01-01 10:05:00
5        | 2       | comment | 2024-01-01 10:10:00
```
*/


Steps
Step 1: Identify Active Users
```sql
SELECT DISTINCT user_id
FROM events
WHERE action IN ('like', 'comment');
```
This step finds users who have performed 'like' or 'comment' actions.

Step 2: Count Inactive Users
```sql
SELECT COUNT(*)
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM events
    WHERE action IN ('like', 'comment')
);
```
This step counts users who have never liked or commented.

Step 3: Calculate Total Users
```sql
SELECT COUNT(*) FROM users;
```
Gets the total number of users in the system.

Step 4: Final Percentage Calculation
```sql
WITH users_count AS (
	SELECT 
		count(*) AS inactive_users,
		(SELECT count(*) FROM users) AS total_users
	FROM users u 
	WHERE u.user_id NOT IN (
		SELECT DISTINCT e.user_id
		FROM events e 
		WHERE e."action" IN ('like', 'comment')
	)
)
SELECT 
	ROUND(
		(uc.inactive_users * 100.0 / uc.total_users)
	, 2) AS inactive_users_percentage
FROM users_count uc;
```

Output
Explanation
### Table Structure:
1. users table contains user information
2. events table tracks user actions (post, like, comment)

### Problem Requirements:
1. Calculate percentage of users who never liked or commented
2. Result must be rounded to 2 decimal places
3. Output should be in decimal format (XX.XX)

### Solution Approach:
1. Use CTE to organize the calculation logic
2. **Find users not in the active users list (never liked/commented)**
3. Calculate percentage using floating-point division
4. Round result to exactly 2 decimal places

### Key Concepts Used:
1. Common Table Expressions (CTEs)
2. Subqueries for counts
3. NOT IN clause for filtering
4. ROUND function for decimal precision
5. Floating-point arithmetic (100.0)
6. Foreign key relationships
7. DISTINCT to avoid duplicate counting