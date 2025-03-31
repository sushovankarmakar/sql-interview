# Sequential Project Pairs Analysis

## Input Data
```sql
SELECT * FROM projects;
```
|id|title|start_date|end_date|budget|
|--|-----|----------|--------|------|
|1|Website Redesign|2024-01-01|2024-02-15|50000.0|
|2|Mobile App Phase 1|2024-02-15|2024-04-01|75000.0|
|3|Database Migration|2024-04-01|2024-05-15|60000.0|
|4|Cloud Integration|2024-03-01|2024-04-15|45000.0|
|5|Security Audit|2024-05-15|2024-06-30|30000.0|

## Question
Write a query to return pairs of projects <br> where the end date of one project matches the start date of another project.

## Steps

### Step 1: Self Join
```sql
SELECT 
    p1.title AS project_title_end,
    p2.title AS project_title_start,
    p1.end_date  
FROM projects p1
JOIN projects p2
    ON p1.end_date = p2.start_date -- self join
    AND p1.id != p2.id; 
```

## Output
|project_title_end|project_title_start|end_date|
|-----------------|-------------------|--------|
|Website Redesign|Mobile App Phase 1|2024-02-15|
|Mobile App Phase 1|Database Migration|2024-04-01|
|Database Migration|Security Audit|2024-05-15|

## Explanation

1. **Table Structure**:
   - Primary key: id
   - Date columns: start_date, end_date
   - Project details: title, budget

2. **Problem Requirements**:
   - Find project pairs where end date matches start date
   - Exclude self-matching projects
   - Show project titles and transition date

3. **Solution Approach**:
   - **Use self-join to compare projects**
   - Match end_date with start_date
   - Add index for performance

4. **Performance Optimization**:
   - Added composite index on date columns
   - Used INNER JOIN for explicit intent
   - Included id comparison to prevent self-matches