CREATE TABLE retail_db.source (
	id INT,
	name VARCHAR(20)
);

INSERT INTO retail_db.source VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D');

CREATE TABLE retail_db.target (
	id INT,
	name VARCHAR(20)
);

INSERT INTO retail_db.target VALUES 
(1, 'A'),
(2, 'B'),
(4, 'X'),
(5, 'E');

-- divide the part into 3 parts
-- 1. find the 'new in source'
-- 2. find the 'new in target'
-- 3. find the 'mismatch'
-- 4. UNION ALL of the above results (why not UNION? because, there was no duplicate values to check on)

(
	-- 1. find the 'new in source'
	SELECT 
		s.id AS id, 
		"New in Source" AS comment  
	FROM source s 
	LEFT JOIN target t 
	ON s.id = t.id 
	WHERE t.id IS NULL
)
UNION ALL
(
	-- 2. find the 'new in target'
	SELECT 
		t.id, 
		"New in Target" 
	FROM target t  
	LEFT JOIN source s 
	ON t.id = s.id  
	WHERE s.id IS NULL
)
UNION ALL
( 
	-- 3. find the 'mismatch'
	SELECT 
		s.id, 
		"Mismatch"  
	FROM source s   
	INNER JOIN target t  
	ON s.id = t.id  
	AND s.name != t.name
);
