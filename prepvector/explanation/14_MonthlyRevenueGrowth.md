# Monthly Revenue Growth Analysis

## Input data
```sql
SELECT * FROM products1;
```
| id  | price  |
|-----|--------|
| 101 | 20.00  |
| 102 | 15.00  |
| 103 | 30.00  |

```sql
SELECT * FROM transactions2;
```
| id | product_id | quantity | created_at           |
|----|------------|----------|---------------------|
| 1  | 101        | 2        | 2019-01-15 10:00:00 |
| 2  | 102        | 1        | 2019-01-20 12:30:00 |
| 3  | 101        | 3        | 2019-02-10 14:00:00 |
| 4  | 103        | 1        | 2019-02-25 16:15:00 |
| 5  | 102        | 4        | 2019-03-05 09:30:00 |
| 6  | 101        | 1        | 2019-03-18 13:45:00 |

---
## Steps

### Step 1: Calculate Monthly Revenue
First, calculate total revenue for each month:
```sql
WITH monthly_revenue AS (
    SELECT 
        EXTRACT(MONTH FROM t.created_at) AS month_num,
        SUM(t.quantity * p.price) AS revenue
    FROM products1 p 
    JOIN transactions2 t ON p.id = t.product_id 
    WHERE EXTRACT(YEAR FROM t.created_at) = 2019
    GROUP BY month_num
    ORDER BY month_num
)
```
Output after Step 1:
| month_num | revenue |
|-----------|---------|
| 1         | 55.00   | -- (2×20) + (1×15)
| 2         | 90.00   | -- (3×20) + (1×30)
| 3         | 80.00   | -- (4×15) + (1×20)

### Step 2: Get Previous Month Revenue
Next, use LAG to get previous month's revenue:
```sql
pre_monthly_revenue AS (
    SELECT 
        mr.month_num,
        mr.revenue,
        LAG(mr.revenue) OVER (ORDER BY mr.month_num) AS pre_month_revenue
    FROM monthly_revenue mr
)
```
Output after Step 2:
| month_num | revenue | pre_month_revenue |
|-----------|---------|------------------|
| 1         | 55.00   | NULL            |
| 2         | 90.00   | 55.00           |
| 3         | 80.00   | 90.00           |

### Step 3: Calculate Month-over-Month Change
Finally, calculate the percentage change:
```sql
SELECT 
    pmr.month_num AS month,
    ROUND(
        COALESCE(
            (pmr.revenue - pmr.pre_month_revenue) * 100 / pmr.pre_month_revenue, 
            0
        ), 
        2
    ) AS month_over_month
FROM pre_monthly_revenue pmr;
```

## Final Output
| month | month_over_month |
|-------|-----------------|
| 1     | 0.00           |
| 2     | 63.64          |
| 3     | -11.11         |

## Explanation

1. **Table Structure**:
   - `products1`: Contains product IDs and their prices
   - `transactions2`: Contains transaction details with quantity and timestamp

2. **Problem Requirements**:
   - Calculate monthly revenue changes for 2019
   - Round results to 2 decimal places
   - Handle first month (no previous month) appropriately

3. **Solution Approach**:
   - Calculate monthly revenue by multiplying quantity with price
   - Use LAG to get previous month's revenue
   - Calculate percentage change using formula: ((current - previous) * 100 / previous)

4. **Key Concepts Used**:
   - `EXTRACT`: To get month from timestamp
   - `LAG`: Window function for previous month's data
   - `COALESCE`: Handle NULL for first month
   - `ROUND`: Format decimal places
   - `GROUP BY`: Aggregate monthly data