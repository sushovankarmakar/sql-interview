CREATE TABLE products (
    product_id INT PRIMARY KEY,
    price DECIMAL(10,2)
);

INSERT INTO products (product_id, price) VALUES
(1, 100.00),
(2, 150.00),
(3, 75.00),
(4, 200.00),
(5, 120.00);

CREATE TABLE product_transactions (
    transaction_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO product_transactions (transaction_id, product_id, amount) VALUES
(1, 1, 95.00),
(2, 1, 98.00),
(3, 2, 145.00),
(4, 2, 150.00),
(5, 3, 70.00),
(6, 4, 190.00),
(7, 4, 195.00),
(8, 5, 115.00);

SELECT * FROM products p ;
SELECT * FROM product_transactions pt ;

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



