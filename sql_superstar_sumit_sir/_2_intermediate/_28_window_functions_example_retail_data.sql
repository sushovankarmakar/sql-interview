
-- 6 tables in retail data
SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM departments;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM products;

-- we need to find top selling product in each category

WITH order_items_and_product AS (
	SELECT 
		oi.order_item_order_id AS order_id, 
		oi.order_item_id,
		oi.order_item_product_id AS product_id, 
		oi.order_item_quantity ,
		oi.order_item_subtotal, 
		p.product_category_id AS category_id,
		p.product_name 
	FROM order_items AS oi  
	JOIN products AS p
	ON oi.order_item_product_id = p.product_id
),
agg_orders AS (
	SELECT 
		op.product_id,
		op.product_name, 
		op.category_id,
		SUM(op.order_item_quantity) AS total_quantity,
		SUM(op.order_item_subtotal) AS total_order 
	FROM order_items_and_product op
	GROUP BY op.product_id, op.product_name, op.category_id -- must include all non-aggregated columns
),
agg_order_category AS (
	SELECT 
		agg.*,
		ROW_NUMBER() OVER (PARTITION BY agg.category_id ORDER BY agg.total_order DESC, agg.total_quantity DESC) AS row_num
	FROM agg_orders agg
)
SELECT * 
FROM agg_order_category x 
WHERE x.row_num = 1;

