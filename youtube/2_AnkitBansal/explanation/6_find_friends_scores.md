*[Find Friends Total Scores SQL Problem](https://www.youtube.com/watch?v=SfzbR69LquU&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=7&ab_channel=AnkitBansal)*

## Input data
|person_id|name|email|score|
|---------|----|-----|-----|
|1|Alice|alice2018@hotmail.com|88|
|2|Bob|bob2018@hotmail.com|11|
|3|Davis|davis2018@hotmail.com|27|
|4|Tara|tara2018@hotmail.com|45|
|5|John|john2018@hotmail.com|63|

|person_id|friend_id|
|---------|---------|
|1|2|
|1|3|
|2|1|
|2|3|
|3|5|
|4|2|
|4|3|
|4|5|


---
## Steps

### Step1: Find Scores of Each Friend

In this step:
- Join persons table with friends table
- Match person_id with friend_id to get friends' scores
- For each person, we get their friends' scores

```sql
SELECT f.person_id
, f.friend_id
, p.score
FROM "_6_persons" p 
JOIN "_6_friends" f ON p.person_id = f.friend_id
ORDER BY f.person_id;
```

|person_id|friend_id|score|
|---------|---------|-----|
|1|3|27|
|1|2|11|
|2|1|88|
|2|3|27|
|3|5|63|
|4|2|11|
|4|5|63|
|4|3|27|


### Step2: Calculate Total Friends and Sum of Friends' Scores
```sql
SELECT f.person_id
, count(f.friend_id) AS total_friends 
, sum(p.score) AS friends_score
FROM "_6_persons" p 
JOIN "_6_friends" f ON p.person_id = f.friend_id
GROUP BY f.person_id
HAVING sum(p.score) > 100
ORDER BY f.person_id;
```
In this step:
- Group by person_id to get aggregates per person
- Count number of friends using count()
- Sum up friends' scores using sum()
- Filter where total friends' score > 100 using HAVING

|person_id|friends_score|
|---------|-------------|
|1|38|
|2|115|
|3|63|
|4|101|

After applying
```sql
HAVING sum(p.score) > 100
```

|person_id|total_friends|friends_score|
|---------|-------------|-------------|
|2|2|115|
|4|3|101|


### Step3: Get Final Result with Person Names
```sql
WITH score_details AS (
    SELECT f.person_id
    , count(f.friend_id) AS total_friends 
    , sum(p.score) AS friends_score
    FROM "_6_persons" p 
    JOIN "_6_friends" f ON p.person_id = f.friend_id
    GROUP BY f.person_id
    HAVING sum(p.score) > 100
)
SELECT sd.person_id
, p.name
, sd.total_friends
, sd.friends_score
FROM "_6_persons" p 
JOIN score_details sd ON p.person_id = sd.person_id;
```

## Output

|person_id|total_friends|friends_score|name|
|---------|-------------|-------------|----|
|2|2|115|Bob|
|4|3|101|Tara|


## Explanation

1. **Table Structure**:
   - Persons table: Contains person details and their scores
   - Friends table: Contains friendship relationships

2. **Problem Requirements**:
   - Find persons who have friends with total score > 100
   - Return person_id, name, number of friends, sum of friends' scores

3. **Solution Approach**:
   - First join gets friends' scores
   - GROUP BY aggregates friends count and scores
   - HAVING filters for total score > 100
   - Final join adds person names to the result

4. **Key Concepts Used**:
   - JOIN operations
   - Aggregate functions (COUNT, SUM)
   - GROUP BY and HAVING clauses
   - Common Table Expression (CTE)