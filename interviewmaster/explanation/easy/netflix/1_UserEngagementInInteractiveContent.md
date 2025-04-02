# User Engagement in Interactive Content Analysis

[Link](https://www.interviewmaster.ai/question/user-engagement-in-interactive-content)

## Input Data
```sql
-- Choices Made Table
SELECT * FROM choices_made ORDER BY choice_id;
```
|choice_id|viewer_id|choice_date|choice_description|
|---------|---------|-----------|------------------|
|1|101|2024-10-06|Go left|
|2|102|2024-10-16|Take the stairs|
|3|103|2024-11-04|Enter the cave|
|4|104|2024-11-21|Climb the mountain|
|5|105|2024-12-08|Explore the forest|
|6|106|2024-10-23|Swim across the river|
|7|107|2024-11-12|Light the torch|
|8|108|2024-12-26|Take the bridge|
|9|109|2024-10-31|Open the door|
|10|110|2024-11-18|Follow the trail|
|11|102|2024-12-06|Take the elevator|
|12|103|2024-10-10|Run away|
|13|104|2024-11-24|Hide in the bushes|
|14|105|2024-12-20|Climb the tree|
|15|106|2024-10-24|Light a fire|


```sql
-- Viewer Interactions Table
SELECT * FROM viewer_interactions ORDER BY interaction_id;
```
|interaction_id|viewer_id|content_id|interaction_type|interaction_date|
|--------------|---------|----------|----------------|----------------|
|1|101|1|pause|2024-10-05|
|2|102|2|choice|2024-10-15|
|3|103|3|pause|2024-11-03|
|4|104|4|choice|2024-11-20|
|5|105|5|pause|2024-12-07|
|6|101|1|choice|2024-12-18|
|7|106|2|pause|2024-10-22|
|8|107|3|choice|2024-11-11|
|9|108|4|pause|2024-12-25|
|10|109|5|choice|2024-10-30|
|11|110|1|pause|2024-11-17|
|12|102|2|choice|2024-12-05|
|13|103|3|pause|2024-10-09|
|14|104|4|choice|2024-11-23|
|15|105|5|pause|2024-12-19|


## Questions & Solutions

### Question 1: October 2024 Unique Viewers

Using the viewer_interactions table, <br> 
how many unique viewers have interacted with any interactive content in October 2024. <br>
Can you find out the number of distinct viewers ? <br>

```sql
SELECT 
    COUNT(DISTINCT viewer_id) as october_viewers
FROM viewer_interactions
WHERE interaction_date >= '2024-10-01'
AND interaction_date < '2024-11-01';
```

|october_viewers|
|---------------|
|5|


### Question 2: November 2024 Unique Choices

To understand viewer preferences, <br> 
the team wants a list of all the unique choices made by viewers in November 2024. <br>
Can you provide this list sorted by choice description alphabetically ? <br>

```sql
SELECT DISTINCT 
    choice_description AS unique_choices_nov
FROM choices_made
WHERE choice_date >= '2024-11-01'
AND choice_date < '2024-12-01'
ORDER BY choice_description ASC;
```

|unique_choices_nov|
|------------------|
|Climb the mountain|
|Enter the cave|
|Follow the trail|
|Hide in the bushes|
|Light the torch|


### Question 3: December 2024 Pause Interactions

The team is interested in understanding <br>
which viewers interacted with content by pausing the video in December 2024. <br>
Can you provide a list of viewer IDs who did this action ? <br>

```sql
SELECT DISTINCT 
    viewer_id AS viewers_dec 
FROM viewer_interactions
WHERE interaction_date >= '2024-12-01'
AND interaction_date < '2025-01-01'
AND interaction_type = 'pause'
ORDER BY viewer_id;
```

|viewers_dec|
|-----------|
|105|
|108|


## Key Concepts Used
1. Date filtering
2. DISTINCT for unique values
3. Conditional filtering
4. Ordering results