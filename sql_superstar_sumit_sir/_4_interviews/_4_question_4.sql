
CREATE TABLE Sessions (
    session_id INT,
    duration INT
);

INSERT INTO Sessions (session_id, duration) VALUES 
(1, 30),
(2, 199),
(3, 299),
(4, 580),
(5, 1000);

SELECT * FROM Sessions s;

WITH reference_table AS (
	SELECT "[0-5>" AS bin 
	UNION ALL 
	SELECT "[5-10>" AS bin 
	UNION ALL 
	SELECT "[10-15>" AS bin 
	UNION ALL 
	SELECT "15 or more" AS bin 
),
bin_category_count AS (
	SELECT  
		CASE 
			WHEN s.duration >= 0 AND s.duration < 300 THEN "[0-5>"
			WHEN s.duration >= 300 AND s.duration < 600 THEN "[5-10>"
			WHEN s.duration >= 600 AND s.duration < 900 THEN "[10-15>"
			WHEN s.duration >= 900 THEN "15 or more"
			END AS bin,
		COUNT(*) AS total 
	FROM Sessions s 
	GROUP BY bin
)
SELECT 
	r.bin, 
	COALESCE(total, 0) AS total 
FROM reference_table r
LEFT JOIN bin_category_count b 
ON r.bin = b.bin;


