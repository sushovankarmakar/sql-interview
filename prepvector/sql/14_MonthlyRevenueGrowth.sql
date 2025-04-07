CREATE TABLE products1 (
    id INT PRIMARY KEY,
    price DECIMAL(10, 2)
);

INSERT INTO products1 (id, price) VALUES
(101, 20.00),
(102, 15.00),
(103, 30.00);

CREATE TABLE transactions2 (
    id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    created_at TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products1(id)
);

INSERT INTO transactions2 (id, product_id, quantity, created_at) VALUES
(1, 101, 2, '2019-01-15 10:00:00'),
(2, 102, 1, '2019-01-20 12:30:00'),
(3, 101, 3, '2019-02-10 14:00:00'),
(4, 103, 1, '2019-02-25 16:15:00'),
(5, 102, 4, '2019-03-05 09:30:00'),
(6, 101, 1, '2019-03-18 13:45:00');

-- Get the month_over_month change in revenue for the year 2019. 
-- Make sure to round month_over_month to 2 decimal places.

WITH monthly_revenue AS (
    -- Calculate total revenue per month
	SELECT 
		EXTRACT(MONTH FROM t.created_at) AS month_num,
		SUM((t.quantity * p.price)) AS revenue
	FROM products1 p 
	JOIN transactions2 t 
	ON p.id = t.product_id 
	WHERE EXTRACT(YEAR FROM t.created_at) = 2019
	GROUP BY month_num -- aggregating only on month
	ORDER BY month_num
),
pre_monthly_revenue AS (
	SELECT 
		mr.month_num,
		mr.revenue,
		lag(mr.revenue) OVER (ORDER BY mr.month_num) AS pre_month_revenue
	FROM monthly_revenue mr
)
SELECT 
	pmr.month_num AS month,
	ROUND(
		COALESCE(
			(pmr.revenue - pmr.pre_month_revenue) * 100 / pmr.pre_month_revenue, 
			0), 
		2) AS month_over_month
FROM pre_monthly_revenue pmr;

