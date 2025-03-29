
## Input

```sql
SELECT * FROM products p ;
```
|product_id|price|
|----------|-----|
|1|100.00|
|2|150.00|
|3|75.00|
|4|200.00|
|5|120.00|

```sql
SELECT * FROM product_transactions pt ;
```
|transaction_id|product_id|amount|
|--------------|----------|------|
|1|1|95.00|
|2|1|98.00|
|3|2|145.00|
|4|2|150.00|
|5|3|70.00|
|6|4|190.00|
|7|4|195.00|
|8|5|115.00|

**Write a query to return the product ID, product price, and average transaction price of all products with a price greater than the average transaction price.**

## Steps
### Step 1: Calculate Average Transaction Price
```sql
SELECT AVG(amount) AS avg_transaction_price
FROM product_transactions;
```
* This calculates the baseline for comparison.

|avg_transaction_price|
|---------------------|
|132.25|
---
* ⚠️Previously I was using `sum(amount) / count(*)` to find out the average, but I should've use `avg(amount)`
---

### Step 2: Compare Products with Average
```sql
WITH avg_transactions AS (
	SELECT 
		AVG(pt.amount) AS avg_transaction_price
	FROM product_transactions pt
)
SELECT 
    p.product_id,
    p.price,
    (SELECT at.avg_transaction_price FROM avg_transactions at)
FROM products p
WHERE p.price > (
    SELECT at.avg_transaction_price
    FROM avg_transactions at
);
```
## Output

|product_id|price|avg_transaction_price|
|----------|-----|---------------------|
|2|150.00|132.25|
|4|200.00|132.25|

## Explanation

1. **Table Structure**:
   - Products: Store product details and prices
   - Transactions: Records of product sales

2. **Problem Requirements**:
   - Find products priced above average transaction amount
   - Include product ID and price
   - Show average for reference

3. **Solution Approach**:
   - Calculate average transaction amount
   - Compare product prices against average
   - Filter and sort results

4. **Performance Optimization**:
```sql
CREATE INDEX idx_transactions_amount ON product_transactions(amount);
CREATE INDEX idx_products_price ON products(price);
```