SELECT * FROM purchases;
SELECT * FROM newsletter_subscriptions;
SELECT * FROM returns;

-- in last 1 month people who interacted in any way
SELECT 
	customer_id, first_name, last_name, email 
FROM purchases 
WHERE purchase_date >= DATE_SUB(current_date(), INTERVAL 1 MONTH)
UNION
SELECT 
	customer_id, first_name, last_name, email 
FROM newsletter_subscriptions 
WHERE subscription_date >= DATE_SUB(current_date(), INTERVAL 1 MONTH)
UNION
SELECT 
	customer_id, first_name, last_name, email 
FROM returns 
WHERE return_date >= DATE_SUB(current_date(), INTERVAL 1 MONTH)


-- Customer who purchased the product and also subscribed to the newsletter
SELECT 
	customer_id, first_name, last_name, email 
FROM purchases
WHERE purchase_date >= DATE_SUB(current_date(), INTERVAL 1 MONTH)
INTERSECT
SELECT 
	customer_id, first_name, last_name, email 
FROM newsletter_subscriptions
WHERE subscription_date >= DATE_SUB(current_date(), INTERVAL 1 MONTH)


SELECT 1, 'Sumit', 10000
UNION 
SELECT 1, 'Sumit', 10000;

SELECT 1, 'Sumit', 10000
UNION ALL 
SELECT 1, 'Sumit', 10000;




