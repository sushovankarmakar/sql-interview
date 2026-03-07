DELIMITER $$

CREATE PROCEDURE sp_get_customers_without_orders()  
BEGIN 
    SELECT 
        c.customer_id, 
        c.customer_fname 
    FROM customers c 
    LEFT JOIN orders o 
    ON c.customer_id = o.order_customer_id 
    WHERE o.order_id IS NULL 
END$$

DELIMITER; 