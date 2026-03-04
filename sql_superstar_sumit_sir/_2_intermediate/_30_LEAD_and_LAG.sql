SELECT 
	e.employee_id, 
	e.salary, 
	LEAD(e.salary) OVER (ORDER BY e.salary DESC) AS next_sal, 
	LAG(e.salary) OVER (ORDER BY e.salary DESC) AS prev_sal 
FROM employees e;

SELECT 
	e.employee_id, 
	e.salary, 
	LEAD(e.salary, 2) OVER (ORDER BY e.salary DESC) AS next_sal, 
	LAG(e.salary, 2) OVER (ORDER BY e.salary DESC) AS prev_sal 
FROM employees e;

SELECT 
	e.employee_id, 
	e.salary, 
	LEAD(e.salary, 2) OVER (ORDER BY e.salary DESC) AS next_sal, 
	LAG(e.salary, 2) OVER (ORDER BY e.salary DESC) AS prev_sal 
FROM employees e;

SELECT 
	e.employee_id, 
	e.salary, 
	LEAD(e.salary, 2, e.salary) OVER (ORDER BY e.salary DESC) AS next_sal, 
	LAG(e.salary, 2, e.salary) OVER (ORDER BY e.salary DESC) AS prev_sal 
FROM employees e;

SELECT 
	e.employee_id, 
	e.salary, 
	LEAD(e.salary, 2, 0) OVER (ORDER BY e.salary DESC) AS next_sal, 
	LAG(e.salary, 2, 0) OVER (ORDER BY e.salary DESC) AS prev_sal 
FROM employees e;


SELECT * FROM sales1 s;

-- Analyze the product’s sales day by day by tracking the quantity sold each day.

SELECT 
	s.*,
	LAG(s.units_sold, 1, 0) OVER (PARTITION BY s.product_id ORDER BY s.sale_date) AS prev_day_sales 
FROM sales1 s;

SELECT 
	s.*,
	LAG(s.units_sold, 1, 0) OVER (PARTITION BY s.product_id ORDER BY s.sale_date) AS lag_result, 
	LEAD(s.units_sold, 1, 0) OVER (PARTITION BY s.product_id ORDER BY s.sale_date DESC) AS lead_result 
FROM sales1 s;






SELECT * FROM social_media_followers AS smf; 

-- Calculate the month-over-month percentage increase in followers on each platform for each user

-- My solution - not optimal
WITH prev_next_followers AS (
	SELECT 
		f.*,
		LEAD(f.linkedin_followers) OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS next_linkedin_followers, 
		LEAD(f.twitter_followers) OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS next_twitter_followers,
		LEAD(f.instagram_followers) OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS next_instagram_followers, 
		LEAD(f.youtube_followers) OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS next_youtube_followers  
	FROM social_media_followers AS f
)
SELECT 
	pnf.user_id,
	pnf.user_name, 
	pnf.`month`,  
	((pnf.next_linkedin_followers - pnf.linkedin_followers)/pnf.linkedin_followers * 100) AS linkedin_diff, 
	((pnf.next_twitter_followers - pnf.twitter_followers)/pnf.twitter_followers * 100)  AS twitter_diff, 
	((pnf.next_instagram_followers - pnf.instagram_followers)/pnf.instagram_followers * 100) AS instagram_diff, 
	((pnf.next_youtube_followers - pnf.youtube_followers)/pnf.youtube_followers * 100) AS youtube_diff 
FROM prev_next_followers pnf 
ORDER BY pnf.user_id;

-- Optimal solution
WITH prev_next_followers AS (
    SELECT
        f.*,
        LAG(f.linkedin_followers)  OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS prev_linkedin_followers,
        LAG(f.twitter_followers)   OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS prev_twitter_followers,
        LAG(f.instagram_followers) OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS prev_instagram_followers,
        LAG(f.youtube_followers)   OVER (PARTITION BY f.user_id ORDER BY f.`month`) AS prev_youtube_followers
    FROM social_media_followers AS f
)
SELECT
    pnf.user_id,
    pnf.user_name,
    pnf.`month`,
    ROUND((pnf.linkedin_followers  - pnf.prev_linkedin_followers)  / NULLIF(pnf.prev_linkedin_followers,  0) * 100, 2) AS linkedin_mom_pct,
    ROUND((pnf.twitter_followers   - pnf.prev_twitter_followers)   / NULLIF(pnf.prev_twitter_followers,   0) * 100, 2) AS twitter_mom_pct,
    ROUND((pnf.instagram_followers - pnf.prev_instagram_followers) / NULLIF(pnf.prev_instagram_followers, 0) * 100, 2) AS instagram_mom_pct,
    ROUND((pnf.youtube_followers   - pnf.prev_youtube_followers)   / NULLIF(pnf.prev_youtube_followers,   0) * 100, 2) AS youtube_mom_pct
FROM prev_next_followers pnf
ORDER BY pnf.user_id, pnf.`month`;


-- Calculate the month-over-month percentage increase in total followers for each user
WITH total_followers_result AS (
	SELECT 
		f.user_id,
		f.user_name,
		f.`month`,
		f.linkedin_followers + f.twitter_followers + f.instagram_followers + f.youtube_followers AS total_followers 
	FROM social_media_followers AS f
),
prev_month_followers_result AS (
	SELECT 
		t.*,
		LAG(t.total_followers, 1, t.total_followers) OVER (PARTITION BY t.user_id ORDER BY t.`month`) AS prev_month_followers 
	FROM total_followers_result t
)
SELECT 
	x.user_id,
	x.user_name,
	x.`month`,
	ROUND((((x.total_followers - x.prev_month_followers) / x.prev_month_followers) * 100), 2) AS followers_mom_pct 
FROM prev_month_followers_result x;




