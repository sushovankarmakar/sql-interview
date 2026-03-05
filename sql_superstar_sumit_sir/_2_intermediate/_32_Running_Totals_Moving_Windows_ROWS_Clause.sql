SELECT * FROM sales1;

-- Running total
SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	-- PARTITION BY s.product_id 
    	ORDER BY s.sale_date
    ) AS running_sales 
FROM sales1 s;

-- Running total for each product
-- you can always give a second column to remove the ties.
SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date, s.product_id
    ) AS running_sales 
FROM sales1 s;

SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.sale_date 
    	ORDER BY s.sale_date, s.product_id
    ) AS running_sales 
FROM sales1 s;


-- what if I need to have a moving window of 3 days
SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date, s.product_id 
    	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW 
    ) AS 3_day_sales  
FROM sales1 s;

SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date DESC  
    	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING  
    ) AS 3_day_sales 
FROM sales1 s;


SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date, s.product_id 
    	ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING  
    ) AS 5_days_sales  
FROM sales1 s;

SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date, s.product_id 
    	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  
    ) AS 5_days_sales  
FROM sales1 s;

-- this is the default behaviour also
SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date, s.product_id 
    	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  
    ) AS 5_days_sales,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date
    ) AS running_total 
FROM sales1 s;


SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date DESC  
    	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING 
    ) AS running_total   
FROM sales1 s;


SELECT 
    s.*,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id 
    	ORDER BY s.sale_date DESC  
    	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING   
    ) AS running_total1,
    SUM(s.units_sold) OVER (
    	PARTITION BY s.product_id
    ) AS running_total2 
FROM sales1 s;




