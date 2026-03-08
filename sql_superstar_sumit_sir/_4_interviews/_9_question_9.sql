CREATE TABLE Transactions (
	id INT PRIMARY KEY,
	country VARCHAR(2),
	state VARCHAR(20),
	amount INT,
	trans_date DATE
);

INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES
(101, 'US', 'approved', 1000, '2019-05-18'),
(102, 'US', 'declined', 2000, '2019-05-19'),
(103, 'US', 'approved', 3000, '2019-06-10'),
(104, 'US', 'declined', 4000, '2019-06-13'),
(105, 'US', 'approved', 5000, '2019-06-15');

CREATE TABLE Chargebacks (
	trans_id INT,
	trans_date DATE
);

INSERT INTO Chargebacks (trans_id, trans_date) VALUES
(102, '2019-05-29'),
(101, '2019-06-30'),
(105, '2019-09-18');


SELECT * FROM Transactions t;
SELECT * FROM Chargebacks c;

WITH transactions_month AS (
	SELECT 
		t.id, 
		t.country, 
		t.state, 
		t.amount, 
		DATE_FORMAT(t.trans_date, '%Y-%m') AS mon 
	FROM transactions AS t 
	WHERE t.state = 'approved'
),
chargebacks_month AS (
	SELECT 
		c.trans_id, 
		t.country, 
		'chargeback' AS state, 
		t.amount, 
		DATE_FORMAT(c.trans_date, '%Y-%m') AS mon 
	FROM chargebacks AS c 
	JOIN transactions AS t 
	ON c.trans_id = t.id
),
all_records_table AS (
	SELECT * FROM transactions_month tm
	UNION ALL 
	SELECT * FROM chargebacks_month cm
) 
SELECT  
	a.mon AS MONTH, 
	a.country, 
	SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
	SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount,
	SUM(CASE WHEN state = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
	SUM(CASE WHEN state = 'chargeback' THEN amount ELSE 0 END) AS chargeback_amount 
FROM all_records_table a 
GROUP BY a.mon, a.country;




