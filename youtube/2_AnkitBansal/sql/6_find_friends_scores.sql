
CREATE TABLE _6_persons (
	person_id int,
	name varchar,
	email varchar,
	score int
);

INSERT INTO "_6_persons"
VALUES 
(1, 'Alice', 'alice2018@hotmail.com', 88),
(2, 'Bob', 'bob2018@hotmail.com', 11),
(3, 'Davis', 'davis2018@hotmail.com', 27),
(4, 'Tara', 'tara2018@hotmail.com', 45),
(5, 'John', 'john2018@hotmail.com', 63);

CREATE TABLE _6_friends (
	person_id int,
	friend_id int
);

INSERT INTO "_6_friends" 
VALUES 
(1,	2),
(1,	3),
(2,	1),
(2,	3),
(3,	5),
(4,	2),
(4,	3),
(4,	5);

-- write a query 
-- to find person_id, name, number of friends, sum of marks of person 
-- who have friends with total score greater than 100

SELECT * FROM "_6_persons" p;
SELECT * FROM "_6_friends" f;

-- join with p.person_id = f.friend_id because to find out each frien id's score

-- 1. for each person, find the scores of each friends

SELECT f.person_id
, f.friend_id
, p.score
FROM "_6_persons" p 
JOIN "_6_friends" f ON p.person_id = f.friend_id
ORDER BY f.person_id; 

-- 2. for each person, find the total score of all its friends
SELECT f.person_id
, sum(p.score) AS friends_score
FROM "_6_persons" p 
JOIN "_6_friends" f ON p.person_id = f.friend_id
GROUP BY f.person_id
ORDER BY f.person_id; 

-- to put filter on aggregated column, we need to use HAVING clause

SELECT f.person_id
, count(f.friend_id) AS total_friends 
, sum(p.score) AS friends_score
FROM "_6_persons" p 
JOIN "_6_friends" f ON p.person_id = f.friend_id
GROUP BY f.person_id
HAVING sum(p.score) > 100
ORDER BY f.person_id;

-- 3. to get person name, we need to join with person table again.

WITH score_details AS (
	SELECT f.person_id
	, count(f.friend_id) AS total_friends 
	, sum(p.score) AS friends_score
	FROM "_6_persons" p 
	JOIN "_6_friends" f ON p.person_id = f.friend_id
	GROUP BY f.person_id
	HAVING sum(p.score) > 100
	ORDER BY f.person_id
)
SELECT sd.*, p."name" 
FROM "_6_persons" p 
JOIN score_details sd
ON p.person_id = sd.person_id;

