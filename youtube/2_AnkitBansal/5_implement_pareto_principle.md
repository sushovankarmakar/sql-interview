*[Complex SQL 5 | Pareto Principle (80/20 Rule) Implementation in SQL](https://www.youtube.com/watch?v=oGgE180oaTs&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=6&ab_channel=AnkitBansal)*

## Input data
```sql
SELECT * FROM "_5_superstore_orders" so;
-- Sample columns: Product_ID, Sales
```
|Product_ID|Sales|
|----------|-----|
|FUR-BO-10001798|261.96|
|FUR-CH-10000454|731.94|
|OFF-LA-10000240|14.62|
|FUR-TA-10000577|957.5775|
|OFF-ST-10000760|22.368|
|FUR-FU-10001487|48.86|
|OFF-AR-10002833|7.28|
|TEC-PH-10002275|907.152|
|OFF-BI-10003910|18.504|
|OFF-AP-10002892|114.9|



---
## Steps

### Step1: Calculate 80% of Total Sales
```sql
WITH total_sales AS (
    SELECT (0.8 * sum(so."Sales")) AS eighty_percent_of_total_sales 
    FROM "_5_superstore_orders" so
)
```

|eighty_percent_of_total_sales|
|-----------------------------|
|1837777.2000000002|


### Step2: Calculate Sales per Product
```sql
WITH product_wise_sales AS (
    SELECT so."Product_ID"
    , sum(so."Sales") AS product_sales
    FROM "_5_superstore_orders" so
    GROUP BY so."Product_ID"
    ORDER BY product_sales DESC
)
```

|Product_ID|product_sales|
|----------|-------------|
|TEC-CO-10004722|61599.824|
|OFF-BI-10003527|27453.385|
|TEC-MA-10002412|22638.48|
|FUR-CH-10002024|21870.574|
|OFF-BI-10001359|19823.479|
|OFF-BI-10000545|19024.5|
|TEC-CO-10001449|18839.688|
|TEC-MA-10001127|18374.895|
|OFF-BI-10004995|17965.066|
|OFF-SU-10000151|17030.312|


### Step3: Calculate Running Sales and Compare with 80% Threshold
```sql
WITH product_running_sales AS (
    SELECT pws."Product_ID"
    , sum(pws.product_sales) OVER (
        ORDER BY product_sales DESC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING
      ) AS running_sales
    , (0.8 * sum(pws.product_sales) OVER ()) AS eighty_percent_of_total_sales
    FROM product_wise_sales pws
)
SELECT * FROM product_running_sales prs
WHERE prs.running_sales <= prs.eighty_percent_of_total_sales;
```

## Output
|Product_ID|running_sales|eighty_percent_of_total_sales|
|----------|-------------|-----------------------------|
|TEC-CO-10004722|61599.824|1837762.6|
|OFF-BI-10003527|89053.21|1837762.6|
|TEC-MA-10002412|111691.69|1837762.6|
|FUR-CH-10002024|133562.27|1837762.6|
|OFF-BI-10001359|153385.75|1837762.6|
|OFF-BI-10000545|172410.25|1837762.6|
|TEC-CO-10001449|191249.94|1837762.6|
|TEC-MA-10001127|209624.83|1837762.6|
|OFF-BI-10004995|227589.89|1837762.6|
|OFF-SU-10000151|244620.2|1837762.6|

## Explanation

1. **First CTE (total_sales)**:
   - Calculates 80% of the total sales across all products
   - This gives us our target threshold

2. **Second CTE (product_wise_sales)**:
   - Groups sales by Product_ID
   - Calculates total sales per product
   - Orders products by their sales in descending order

3. **Third CTE (product_running_sales)**:
   - Uses window function to calculate running sum of sales
   - `ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING` creates cumulative sum
   - Also calculates 80% threshold for comparison

4. **Final Query**:
   - Filters products where running sales are within 80% threshold
   - These products represent the top 20% that generate 80% of sales

