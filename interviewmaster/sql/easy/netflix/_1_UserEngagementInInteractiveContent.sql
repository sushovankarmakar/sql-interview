
-- https://www.interviewmaster.ai/question/user-engagement-in-interactive-content

-- Create the choices_made table
CREATE TABLE choices_made (
    choice_id INTEGER PRIMARY KEY,
    viewer_id INTEGER NOT NULL,
    choice_date DATE NOT NULL,
    choice_description VARCHAR(100) NOT NULL
);

-- Insert sample data
INSERT INTO choices_made 
(choice_id, viewer_id, choice_date, choice_description) 
VALUES
(1, 101, '2024-10-06', 'Go left'),
(2, 102, '2024-10-16', 'Take the stairs'),
(3, 103, '2024-11-04', 'Enter the cave'),
(4, 104, '2024-11-21', 'Climb the mountain'),
(5, 105, '2024-12-08', 'Explore the forest'),
(6, 106, '2024-10-23', 'Swim across the river'),
(7, 107, '2024-11-12', 'Light the torch'),
(8, 108, '2024-12-26', 'Take the bridge'),
(9, 109, '2024-10-31', 'Open the door'),
(10, 110, '2024-11-18', 'Follow the trail'),
(11, 102, '2024-12-06', 'Take the elevator'),
(12, 103, '2024-10-10', 'Run away'),
(13, 104, '2024-11-24', 'Hide in the bushes'),
(14, 105, '2024-12-20', 'Climb the tree'),
(15, 106, '2024-10-24', 'Light a fire');

-- Verify the data
SELECT * FROM choices_made ORDER BY choice_id;


-- Create the viewer_interactions table
CREATE TABLE viewer_interactions (
    interaction_id INTEGER PRIMARY KEY,
    viewer_id INTEGER NOT NULL,
    content_id INTEGER NOT NULL,
    interaction_type VARCHAR(50) NOT NULL,
    interaction_date DATE NOT NULL
);

-- Insert sample data
INSERT INTO viewer_interactions 
(interaction_id, viewer_id, content_id, interaction_date, interaction_type) 
VALUES
(1, 101, 1, '2024-10-05', 'pause'),
(2, 102, 2, '2024-10-15', 'choice'),
(3, 103, 3, '2024-11-03', 'pause'),
(4, 104, 4, '2024-11-20', 'choice'),
(5, 105, 5, '2024-12-07', 'pause'),
(6, 101, 1, '2024-12-18', 'choice'),
(7, 106, 2, '2024-10-22', 'pause'),
(8, 107, 3, '2024-11-11', 'choice'),
(9, 108, 4, '2024-12-25', 'pause'),
(10, 109, 5, '2024-10-30', 'choice'),
(11, 110, 1, '2024-11-17', 'pause'),
(12, 102, 2, '2024-12-05', 'choice'),
(13, 103, 3, '2024-10-09', 'pause'),
(14, 104, 4, '2024-11-23', 'choice'),
(15, 105, 5, '2024-12-19', 'pause');

SELECT * FROM viewer_interactions ORDER BY interaction_id;

-- QUESTION : 1
-- Using the viewer_interactions table, 
-- how many unique viewers have interacted with any interactive content in October 2024. 
-- Can you find out the number of distinct viewers ?

-- PostgreSQL solution
-- note : SQLite don't support EXTRACT function
SELECT 
    COUNT(DISTINCT viewer_id) as october_viewers
FROM viewer_interactions
WHERE EXTRACT(YEAR FROM interaction_date) = 2024
AND EXTRACT(MONTH FROM interaction_date) = 10;

-- alternate approach
SELECT 
    COUNT(DISTINCT viewer_id) as october_viewers
FROM viewer_interactions
WHERE interaction_date >= '2024-10-01'
AND interaction_date < '2024-11-01';

------------------------------------------------------------------------------------------------------

-- QUESTION : 2
-- To understand viewer preferences, 
-- the team wants a list of all the unique choices made by viewers in November 2024. 
-- Can you provide this list sorted by choice description alphabetically ?

SELECT DISTINCT choice_description AS unique_choices_nov
FROM choices_made cm
WHERE cm.choice_date >= '2024-11-01'
AND cm.choice_date < '2024-12-01'
ORDER BY choice_description ASC;

-- QUESTION : 3
-- The team is interested in understanding 
-- which viewers interacted with content by pausing the video in December 2024. 
-- Can you provide a list of viewer IDs who did this action?

SELECT DISTINCT vi.viewer_id AS viewers_dec 
FROM viewer_interactions vi
WHERE vi.interaction_date >= '2024-12-01'
AND vi.interaction_date < '2025-01-01'
AND vi.interaction_type = 'pause'
ORDER BY vi.viewer_id;


