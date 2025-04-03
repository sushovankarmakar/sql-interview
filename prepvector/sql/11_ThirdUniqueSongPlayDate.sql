CREATE TABLE song_users (
    id INTEGER PRIMARY KEY,
    username VARCHAR(50)
);

INSERT INTO song_users (id, username) VALUES
(1, 'john_doe'),
(2, 'jane_smith'),
(3, 'bob_wilson');

CREATE TABLE song_plays (
    id INTEGER PRIMARY KEY,
    played_at TIMESTAMP,
    user_id INTEGER,
    song_id INTEGER
);

INSERT INTO song_plays 
(id, played_at, user_id, song_id) 
VALUES
(1, '2024-01-01 10:00:00', 1, 101),
(2, '2024-01-01 14:00:00', 1, 101),
(3, '2024-01-02 09:00:00', 1, 102),
(4, '2024-01-03 16:00:00', 1, 103),
(5, '2024-01-04 11:00:00', 1, 104),
(6, '2024-01-01 09:00:00', 2, 201),
(7, '2024-01-01 15:00:00', 2, 202),
(8, '2024-01-02 10:00:00', 2, 203),
(9, '2024-01-02 14:00:00', 2, 203),
(10, '2024-01-01 12:00:00', 3, 301),
(11, '2024-01-02 13:00:00', 3, 302);

SELECT * FROM song_users su ORDER BY su.id;
SELECT * FROM song_plays sp ORDER BY sp.id;


--Given a table of song_plays and a table of users, 
-- write a query to extract the earliest date each user played their third unique song and order by date played.

-- sample output :
-- (4, '2024-01-03 16:00:00', 1, 103),
-- (8, '2024-01-02 10:00:00', 2, 203),

WITH song_ranks AS (
	SELECT 
	  user_id, 
	  played_at,
	  song_id,
	  dense_rank() OVER (PARTITION BY user_id ORDER BY song_id) AS song_rank
	FROM song_plays
),
third_unique_song AS (
  SELECT 
    user_id, 
    song_id,
    min(played_at) as created_at
  FROM song_ranks sr
  WHERE sr.song_rank = 3
  group by user_id, song_id
)
SELECT 
  u.username,
  tus.song_id,
  tus.created_at
FROM third_unique_song tus
JOIN song_users u
ON tus.user_id = u.id
ORDER BY tus.created_at;