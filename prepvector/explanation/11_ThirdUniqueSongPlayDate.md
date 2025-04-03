# Third Unique Song Play Date Analysis

## Input Data
```sql
-- Users Table
SELECT * FROM users;
```
|id|username|
|--|--------|
|1|john_doe|
|2|jane_smith|
|3|bob_wilson|

```sql
-- Song Plays Table
SELECT * FROM song_plays;
```
|id|played_at|user_id|song_id|
|--|---------|--------|-------|
|1|2024-01-01 10:00:00|1|101|
|2|2024-01-01 14:00:00|1|101|
|3|2024-01-02 09:00:00|1|102|
// ...existing data...

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
This assigns sequential ranks to unique songs for each user.

### Step 2: Find Third Song Details
```sql
third_unique_song AS (
    SELECT 
        user_id, 
        song_id,
        MIN(played_at) as created_at,
        song_rank 
    FROM song_ranks
    WHERE song_rank = 3
    GROUP BY user_id, song_id
)
```
This finds the earliest play time of each user's third unique song.

### Step 3: Get Final Results
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
```sql
username   | song_id | created_at
-----------|---------|------------------------
jane_smith | 203     | 2024-01-02 10:00:00
john_doe   | 103     | 2024-01-03 16:00:00
```

## Performance Tips
```sql
CREATE INDEX idx_song_plays_user_song 
ON song_plays(user_id, song_id);
CREATE INDEX idx_song_plays_played_at 
ON song_plays(played_at);
```