CREATE TABLE transactions1 (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    created_at TIMESTAMPTZ,
    product_id INTEGER,
    quantity INTEGER
);

INSERT INTO transactions1 (id, user_id, created_at, product_id, quantity) VALUES
(1, 101, '2024-01-01 10:00:00', 1, 1),  
(2, 101, '2024-01-01 14:00:00', 2, 1),
(3, 101, '2024-01-15 09:00:00', 3, 1), 
(4, 102, '2024-01-05 11:00:00', 1, 2),
(5, 102, '2024-01-05 11:30:00', 2, 1),
(6, 103, '2024-01-02 15:00:00', 1, 1),
(7, 104, '2024-01-01 09:00:00', 1, 1),
(8, 104, '2024-01-02 10:00:00', 2, 1),
(9, 104, '2024-01-03 11:00:00', 3, 1);

-- Write a query to get the number of customers that were upsold by purchasing additional products.

-- Note: If a customer purchased multiple products on the same day, it does not count as an upsell. 
-- An upsell is considered only if they made purchases on separate days

SELECT * FROM transactions1 t ;

WITH user_date_count AS (
  SELECT 
    t.user_id,
    COUNT(DISTINCT DATE(t.created_at)) AS date_count
  FROM transactions1 t
  GROUP BY t.user_id
)
SELECT count(user_id) AS upsold_customer_count
FROM user_date_count udc
WHERE udc.date_count > 1;


