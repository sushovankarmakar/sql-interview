/**
 * https://leetcode.com/problems/consecutive-numbers/
 * 
 * https://www.youtube.com/watch?v=smd03AqX5LA&ab_channel=FrederikM%C3%BCller
 */ 

/*
Write an SQL query to find all numbers that appear at least three times consecutively.
Return the result table in any order.

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.

*/

SELECT DISTINCT a.num as ConsecutiveNums FROM Logs a 
JOIN Logs b ON a.id = b.id + 1 AND a.num = b.num
JOIN Logs c ON a.id = c.id + 2 AND a.num = c.num;