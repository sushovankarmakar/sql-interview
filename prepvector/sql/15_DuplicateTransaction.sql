CREATE TABLE transactions_merchant (
	id INT PRIMARY KEY,
	credit_card VARCHAR(20),
	merchant VARCHAR(50),
	amount DECIMAL(10, 2),
	transaction_time TIMESTAMP
);

INSERT INTO transactions_merchant (id, credit_card, merchant, amount, transaction_time)
VALUES
(1, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 10:15:00'),
(2, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 10:20:00'),
(3, '5678-1234-8765', 'Walmart', 30.00, '2025-01-23 11:00:00'),
(4, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 10:30:00'),
(5, '5678-1234-8765', 'Walmart', 30.00, '2025-01-23 11:05:00'),
(6, '8765-4321-1234', 'BestBuy', 100.00, '2025-01-23 12:00:00'),
(7, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 12:10:00');

SELECT * FROM transactions_merchant;

-- Using the transactions table, 
-- identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. 
-- Count such repeated payments.

-- Assumption:
-- The first transaction of such payments should not be counted as a repeated payment. 
-- This means that if a merchant performs 2 transactions with the same credit card and for the same amount within 10 minutes, 
-- there will only be 1 repeated payment.

----- OLD SOLUTION
WITH time_gap_details AS (
	SELECT 
		coalesce(
			t.transaction_time - lag(transaction_time, 1) OVER (PARTITION BY t.credit_card ORDER BY t.transaction_time),
			'00:00:00'
		) AS time_gap
	FROM transactions_merchant t
)
SELECT 
	COUNT(*) AS repeated_payment_count 
FROM time_gap_details tgd
WHERE tgd.time_gap >= '00:00:01' AND tgd.time_gap <= '00:10:00';

-- What are things I was doing wrong :

-- 1. Missing Grouping Conditions: 
-- Your solution only checks time gaps but doesn't consider:
-- Same merchant
-- Same amount
-- Same credit card

-- 2. Window Function Partitioning: 
-- The LAG should partition by all three criteria

----- NEW SOLUTION
With transaction_groups AS (
	SELECT
		t.*,
		LAG(transaction_time) OVER (
			PARTITION BY credit_card, merchant, amount
			ORDER BY transaction_time
		) AS prev_transaction_time
	 FROM transactions_merchant t
),
duplicate_checks AS (
	SELECT
		id,
		CASE 
			WHEN prev_transaction_time IS NOT NULL
			AND (transaction_time - prev_transaction_time) <= INTERVAL '10 minutes'
			THEN 1
			ELSE 0
		END as is_duplicate
	FROM transaction_groups
)
SELECT COUNT(id) as repeated_payment_count
FROM duplicate_checks
WHERE is_duplicate = 1;