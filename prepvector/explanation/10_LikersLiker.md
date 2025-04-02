# Likers' Likers Analysis

## Input Data
```sql
SELECT * FROM likes;
```
|user_id|created_at|liker_id|
|-------|----------|--------|
|A|2024-01-01 10:00:00|B|
|B|2024-01-01 11:00:00|C|
|B|2024-01-01 12:00:00|D|
|B|2024-01-01 13:00:00|E|
|C|2024-01-02 10:00:00|A|
|D|2024-01-02 14:00:00|E|
|E|2024-01-02 15:00:00|F|
|B|2024-01-03 09:00:00|G|
|H|2024-01-03 10:00:00|A|
|B|2024-01-03 11:00:00|C|
|I|2024-01-03 12:00:00|I|


## Steps

```sql
SELECT 
	l.user_id, 
	COUNT(DISTINCT l.liker_id) as count 
FROM likes l
WHERE l.user_id != l.liker_id
GROUP BY l.user_id;
```

### Step 1: 

## Output
|user_id|count|
|-------|-----|
|A|1|
|B|4|
|C|1|
|D|1|
|E|1|
|H|1|


## Explanation

1. **Table Structure**:
   - likes: Tracks user likes
   - Columns: user_id, created_at, liker_id
   - Represents directional relationships

2. **Problem Requirements**:
   - Group by using user_id

3. **Key Concepts**:
   - Self joins
   - DISTINCT counting
   - Multiple level relationships