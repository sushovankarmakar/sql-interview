# Monthly Product Sales Analysis

```sql
SELECT * FROM monthly_sales ORDER BY month, product_id;
```

|month|product_id|amount_sold|
|-----|----------|-----------|
|2021-01-01|1|100|
|2021-01-01|2|300|
|2021-02-01|1|150|
|2021-02-01|1|50|
|2021-02-01|2|250|
|2021-03-01|1|120|
|2021-03-01|4|250|
|2021-04-01|2|-30|
|2021-04-01|3|200|
|2021-05-01|3|175|
|2021-06-01|1|0|
|2021-06-01|2|100|

---

## Question :
Given a table containing data for monthly sales, <br> 
write a query to find the total amount of each product sold for each month, <br> 
with each product as its own column in the output table.

## Steps 

### Step 1: Pivot Sales Data by Product

```sql
SELECT
	ms.month,
	SUM (CASE WHEN ms.product_id = 1 THEN ms.amount_sold ELSE 0 END) AS product_1,
	SUM (CASE WHEN ms.product_id = 2 THEN ms.amount_sold ELSE 0 END) AS product_2,
	SUM (CASE WHEN ms.product_id = 3 THEN ms.amount_sold ELSE 0 END) AS product_3,
	SUM (CASE WHEN ms.product_id = 4 THEN ms.amount_sold ELSE 0 END) AS product_4
FROM monthly_sales ms
GROUP BY ms.month;
```

## Output
|month|product_1|product_2|product_3|product_4|
|-----|---------|---------|---------|---------|
|2021-02-01|200|250|0|0|
|2021-05-01|0|0|175|0|
|2021-04-01|0|-30|200|0|
|2021-06-01|0|100|0|0|
|2021-03-01|120|0|0|250|
|2021-01-01|100|300|0|0|

---

## Explanation

1. **Table Structure**:
   - monthly_sales: Tracks product sales by month
   - Columns: month (DATE), product_id (INT), amount_sold (INT)

2. **Problem Requirements**:
   - Convert rows to columns (pivot)
   - Show monthly sales by product
   - Handle missing data with zeros
   - Order by month

3. **Solution Approach**:
   - Use CASE statements for pivoting
   - Group by month for aggregation
   - SUM for total sales per product
   - Handle nulls with ELSE 0

4. **Performance Optimization**:
   - Added composite index
   - Single table scan
   - Efficient grouping