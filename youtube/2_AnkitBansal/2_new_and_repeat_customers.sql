
CREATE TABLE customer_orders (
	order_id int,
	customer_id int,
	order_date date,
	order_amount float
)

INSERT INTO _2_customer_orders 
VALUES
(1, 100, CAST('2022-01-01' AS date), 2000),
(2, 200, cast('2022-01-01' as date), 2500),
(3, 300, cast('2022-01-01' as date), 2100),
(4, 100, cast('2022-01-02' as date), 2000),
(5, 400, cast('2022-01-02' as date), 2200),
(6, 500, cast('2022-01-02' as date), 2700),
(7, 100, cast('2022-01-03' as date), 3000),
(8, 400, cast('2022-01-03' as date), 1000),
(9, 600, cast('2022-01-03' as date), 3000);

SELECT * FROM _2_customer_orders ;


-- 1. find out when was the first time a customer ordered

WITH first_order_date AS (
	-- 1. find out when was the first time a customer ordered
	SELECT co.customer_id, min(co.order_date) AS first_order_date
	FROM _2_customer_orders co 
	GROUP BY co.customer_id
)
SELECT co.order_date,
	-- number of new orders and old orders
	sum(CASE WHEN co.order_date = fod.first_order_date THEN 1 ELSE 0 END) AS new_orders,
	sum(CASE WHEN co.order_date != fod.first_order_date THEN 1 ELSE 0 END) AS old_orders,
	-- total order amount of new orders and old orders
	sum(CASE WHEN co.order_date = fod.first_order_date THEN co.order_amount ELSE 0 END) AS new_order_amount,
	sum(CASE WHEN co.order_date != fod.first_order_date THEN co.order_amount ELSE 0 END) AS old_order_amount
FROM 
_2_customer_orders co
JOIN 
first_order_date fod
ON co.customer_id = fod.customer_id
GROUP BY co.order_date
ORDER BY co.order_date;
