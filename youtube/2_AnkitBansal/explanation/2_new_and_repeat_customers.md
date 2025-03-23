*[Complex SQL 2 | find new and repeat customers | SQL Interview Questions](https://www.youtube.com/watch?v=MpAMjtvarrc&ab_channel=AnkitBansal)*

## Input data

```sql
SELECT * FROM _2_customer_orders ;
```
|order_id|customer_id|order_date|order_amount|
|--------|-----------|----------|------------|
|1|100|2022-01-01|2000.0|
|2|200|2022-01-01|2500.0|
|3|300|2022-01-01|2100.0|
|4|100|2022-01-02|2000.0|
|5|400|2022-01-02|2200.0|
|6|500|2022-01-02|2700.0|
|7|100|2022-01-03|3000.0|
|8|400|2022-01-03|1000.0|
|9|600|2022-01-03|3000.0|

# Find out new and old orders by each day

## Steps :

### 1. Find out when was the first time a customer ordered

```sql
SELECT 
	co.customer_id, 
	min(co.order_date) AS first_order_date
FROM "_2_customer_orders" co 
GROUP BY co.customer_id
```

|customer_id|first_order_date|
|-----------|----------------|
|500|2022-01-02|
|200|2022-01-01|
|400|2022-01-02|
|300|2022-01-01|
|600|2022-01-03|
|100|2022-01-01|

### 2. Join with CTE on customer_id

```sql
	...
	SELECT co.order_date,
		CASE WHEN co.order_date = fod.first_order_date THEN 1 ELSE 0 END) AS new_orders,
	FROM 
	_2_customer_orders co JOIN first_order_date fod
	ON co.customer_id = fod.customer_id
	GROUP BY co.order_date
	ORDER BY co.order_date;
```

|order_id|customer_id|order_date|order_amount|customer_id|first_order_date|new_orders|
|--------|-----------|----------|------------|-----------|----------------|-----------|
|1|100|2022-01-01|2000.0|100|2022-01-01|1|
|2|200|2022-01-01|2500.0|200|2022-01-01|1|
|3|300|2022-01-01|2100.0|300|2022-01-01|1|
|4|100|2022-01-02|2000.0|100|2022-03-01|0|
|5|400|2022-01-02|2200.0|400|2022-01-03|0|
|6|500|2022-01-02|2700.0|500|2022-01-02|1|
|7|100|2022-01-03|3000.0|100|2022-03-01|0|
|8|400|2022-01-03|1000.0|400|2022-01-03|1|
|9|600|2022-01-03|3000.0|600|2022-01-03|1|

### 3. CASE and SUM aggregation 

```sql
WITH first_order_date AS (
	-- 1. find out when was the first time a customer ordered
	SELECT co.customer_id, min(co.order_date) AS first_order_date
	FROM _2_customer_orders co 
	GROUP BY co.customer_id
)
SELECT co.order_date,
	sum(CASE WHEN co.order_date = fod.first_order_date THEN 1 ELSE 0 END) AS new_orders,
	sum(CASE WHEN co.order_date != fod.first_order_date THEN 1 ELSE 0 END) AS old_orders
FROM 
_2_customer_orders co
JOIN 
first_order_date fod
ON co.customer_id = fod.customer_id
GROUP BY co.order_date
ORDER BY co.order_date;
```

## FINAL OUTPUT - 1

|order_date|new_orders|old_orders|
|----------|----------|----------|
|2022-01-01|3|0|
|2022-01-02|2|1|
|2022-01-03|1|2|

---
---

# Find out new and old order amounts

```sql
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
```

## FINAL OUTPUT - 2

|order_date|new_orders|old_orders|new_order_amount|old_order_amount|
|----------|----------|----------|----------------|----------------|
|2022-01-01|3|0|6600.0|0.0|
|2022-01-02|2|1|4900.0|2000.0|
|2022-01-03|1|2|3000.0|4000.0|
