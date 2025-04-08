# Duplicate Transaction Detection

## Input data
```sql
SELECT * FROM transactions_merchant;
```
|id|credit_card|merchant|amount|transaction_time|
|--|-----------|--------|------|----------------|
|1|1234-5678-9876|Amazon|50.00|2025-01-23 10:15:00|
|2|1234-5678-9876|Amazon|50.00|2025-01-23 10:20:00|
|3|5678-1234-8765|Walmart|30.00|2025-01-23 11:00:00|
|4|1234-5678-9876|Amazon|50.00|2025-01-23 10:30:00|
|5|5678-1234-8765|Walmart|30.00|2025-01-23 11:05:00|
|6|8765-4321-1234|BestBuy|100.00|2025-01-23 12:00:00|
|7|1234-5678-9876|Amazon|50.00|2025-01-23 12:10:00|

---
## Question :
Using the transactions table, <br>
**identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other.** <br>
Count such repeated payments. <br>

*Assumption*: <br>
The first transaction of such payments should not be counted as a repeated payment. <br>
This means that if a merchant performs 2 transactions with the same credit card and for the same amount within 10 minutes, 
there will only be 1 repeated payment. <br>

---
## Steps

### Step 1: Group Similar Transactions
First, we group transactions by card, merchant, and amount to identify potential duplicates:
```sql
WITH transaction_groups AS (
    SELECT
        t.*,
        LAG(transaction_time) OVER (
            PARTITION BY credit_card, merchant, amount
            ORDER BY transaction_time
        ) AS prev_transaction_time
    FROM transactions_merchant t
)
```
Sample output after Step 1:
| id | credit_card | merchant | amount | transaction_time | prev_transaction_time |
|----|-------------|----------|---------|------------------|---------------------|
| 1 | 1234-5678-9876 | Amazon | 50.00 | 10:15:00 | NULL |
| 2 | 1234-5678-9876 | Amazon | 50.00 | 10:20:00 | 10:15:00 |
| 4 | 1234-5678-9876 | Amazon | 50.00 | 10:30:00 | 10:20:00 |
| 3 | 5678-1234-8765 | Walmart | 30.00 | 11:00:00 | NULL |

### Step 2: Identify Duplicate Transactions
Next, we check for transactions within 10 minutes:
```sql
duplicate_checks AS (
    SELECT
        id,
        CASE 
            WHEN prev_transaction_time IS NOT NULL 
            AND (transaction_time - prev_transaction_time) <= INTERVAL '10 minutes'
            THEN 1 
            ELSE 0 
        END as is_duplicate
    FROM transaction_groups
)
```
Sample output after Step 2:
| id | is_duplicate |
|----|-------------|
| 1 | 0 | -- First transaction
| 2 | 1 | -- Within 10 mins of #1
| 4 | 1 | -- Within 10 mins of #2
| 3 | 0 | -- First Walmart transaction

### Step 3: Count Duplicates
Finally, count transactions marked as duplicates:
```sql
SELECT COUNT(id) as repeated_payment_count
FROM duplicate_checks
WHERE is_duplicate = 1;
```

## Final Output
| repeated_payment_count |
|-----------------------|
| 3 |

## Explanation

1. **Table Structure**:
   - `transactions_merchant`: Contains transaction details including card, merchant, amount, and timestamp

2. **Problem Requirements**:
   - Find transactions with same card, merchant, and amount
   - Within 10 minutes of each other
   - First transaction doesn't count as duplicate
   - Return total count of duplicates

3. **Solution Approach**:
   - Group by card, merchant, and amount
   - Use LAG to find previous transaction time
   - Check time difference ≤ 10 minutes
   - Count qualifying transactions

4. **Key Concepts Used**:
   - `LAG`: Window function to get previous transaction
   - `INTERVAL`: PostgreSQL time interval
   - `PARTITION BY`: Group similar transactions
   - `CASE`: Identify duplicates