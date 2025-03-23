-- pareto principle says '80% of your sales comes from 20% of your products'

-- so the question is : 
-- give me those top products which generates 80% of total sales;

SELECT * FROM "_5_superstore_orders" so LIMIT 20;

-- 1. find out the 80% of total sales; -- 18,37,777
SELECT (0.8 * sum(so."Sales")) AS eighty_percent_of_total_sales 
FROM "_5_superstore_orders" so
-- 2. find top products order by sales per product and calculate running sales on this.

WITH product_wise_sales AS
(
	SELECT so."Product_ID", sum(so."Sales") AS product_sales
	FROM "_5_superstore_orders" so
	GROUP BY so."Product_ID"
	ORDER BY product_sales DESC
),
product_running_sales AS (
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

