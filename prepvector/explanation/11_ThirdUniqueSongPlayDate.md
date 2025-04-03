# Third Unique Song Play Date Analysis

### [Question link](https://challenges.prepvector.com/challenges/fe090a86-abf5-4e46-92b4-6fc5ce069bc3/questions/987dc4f8-d365-426c-ba59-90594b3f941d)

## Input Data
```sql
-- Users Table
SELECT * FROM users u ORDER BY u.id;
```
|id|username|
|--|--------|
|1|john_doe|
|2|jane_smith|
|3|bob_wilson|

```sql
-- Song Plays Table
SELECT * FROM song_plays sp ORDER BY sp.id;
```
|id|played_at|user_id|song_id|
|--|---------|-------|-------|
|1|2024-01-01 10:00:00|1|101|
|2|2024-01-01 14:00:00|1|101|
|3|2024-01-02 09:00:00|1|102|
|4|2024-01-03 16:00:00|1|103|
|5|2024-01-04 11:00:00|1|104|
|6|2024-01-01 09:00:00|2|201|
|7|2024-01-01 15:00:00|2|202|
|8|2024-01-02 10:00:00|2|203|
|9|2024-01-02 14:00:00|2|203|
|10|2024-01-01 12:00:00|3|301|
|11|2024-01-02 13:00:00|3|302|

## Question :
Given a table of song_plays and a table of users, <br>
**Write a query to extract the earliest date each user played their third unique song and order by date played.**


## Steps

### Step 1: Rank Unique Songs per User
```sql
WITH song_ranks AS (
    SELECT 
        user_id, 
        played_at,
        song_id,
        DENSE_RANK() OVER (
            PARTITION BY user_id 
            ORDER BY song_id
        ) AS song_rank
    FROM song_plays
)
```
* This assigns sequential ranks to unique songs for each user.

|user_id|played_at|song_id|song_rank|
|-------|---------|-------|---------|
|1|2024-01-01 10:00:00|101|1|
|1|2024-01-01 14:00:00|101|1|
|1|2024-01-02 09:00:00|102|2|
|1|2024-01-03 16:00:00|103|3|
|1|2024-01-04 11:00:00|104|4|
|2|2024-01-01 09:00:00|201|1|
|2|2024-01-01 15:00:00|202|2|
|2|2024-01-02 10:00:00|203|3|
|2|2024-01-02 14:00:00|203|3|
|3|2024-01-01 12:00:00|301|1|
|3|2024-01-02 13:00:00|302|2|

### Step 2: Find Third Song Details
```sql
third_unique_song AS (
    SELECT 
        user_id, 
        song_id,
        MIN(played_at) as created_at
    FROM song_ranks
    WHERE song_rank = 3
    GROUP BY user_id, song_id
)
```
* This finds the earliest play time of each user's third unique song.

|user_id|song_id|created_at|
|-------|-------|----------|
|1|103|2024-01-03 16:00:00|
|2|203|2024-01-02 10:00:00|


### Step 3: Get Final Results with Join
```sql
SELECT 
    u.username,
    tus.song_id,
    tus.created_at
FROM third_unique_song tus
JOIN users u ON tus.user_id = u.id
ORDER BY tus.created_at;
```

## Output

|username|song_id|created_at|
|--------|-------|----------|
|jane_smith|203|2024-01-02 10:00:00|
|john_doe|103|2024-01-03 16:00:00|


## Performance Tips
```sql
CREATE INDEX idx_song_plays_user_song 
ON song_plays(user_id, song_id);
CREATE INDEX idx_song_plays_played_at 
ON song_plays(played_at);
```