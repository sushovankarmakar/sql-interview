CREATE TABLE projects (
    id INTEGER PRIMARY KEY, 
    title VARCHAR(100),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    budget FLOAT
);

INSERT INTO projects (id, title, start_date, end_date, budget) VALUES
(1, 'Website Redesign', '2024-01-01', '2024-02-15', 50000),
(2, 'Mobile App Phase 1', '2024-02-15', '2024-04-01', 75000),
(3, 'Database Migration', '2024-04-01', '2024-05-15', 60000),
(4, 'Cloud Integration', '2024-03-01', '2024-04-15', 45000),
(5, 'Security Audit', '2024-05-15', '2024-06-30', 30000);

-- Write a query to return pairs of projects where the end date of one project matches the start date of another project.

SELECT 
    p1.title AS project_title_end,
    p2.title AS project_title_start,
    p1.end_date  
FROM projects p1
JOIN projects p2
    ON p1.end_date = p2.start_date -- self join
    AND p1.id != p2.id; 