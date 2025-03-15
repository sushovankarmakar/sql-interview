/*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */

SELECT e.title, e.last_name , e.first_name, e.levels 
FROM employee e 
ORDER BY e.levels DESC 
LIMIT 1;

/* Q2: Which countries have the most Invoices? */

SELECT i.billing_country, count(i.invoice_id) AS num_of_invoice
FROM invoice i 
GROUP BY i.billing_country
ORDER BY num_of_invoice DESC;

/* Q3: What are top 3 values of total invoice? */

SELECT i.invoice_id, i.total FROM invoice i
ORDER BY total DESC 
LIMIT 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT i.billing_city, sum(i.total) AS total_money FROM invoice i 
GROUP BY i.billing_city
ORDER BY total_money DESC ;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT c.customer_id, c.first_name, c.last_name, sum(i.total) AS sum_total
FROM customer c JOIN invoice i 
ON c.customer_id = i.customer_id 
GROUP BY c.customer_id
ORDER BY sum_total DESC
LIMIT 1;




/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

-- simple approach
SELECT DISTINCT c.email, c.first_name, c.last_name, g."name" 
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g."name" = 'Rock'
ORDER BY c.email ASC ;

-- more optimal approach 
SELECT DISTINCT c.email, c.first_name, c.last_name 
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE il.track_id IN (
	SELECT track_id 
	FROM track t
	JOIN genre g ON t.genre_id = g.genre_id 
	WHERE g."name" = 'Rock'
)
ORDER BY c.email ASC ;


/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT a."name", count(a.artist_id) AS total_songs 
FROM artist a 
JOIN album al ON a.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g."name" = 'Rock'
GROUP BY a.artist_id 
ORDER BY total_songs DESC 
LIMIT 10;


/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT t.track_id, t."name", t.milliseconds 
FROM track t 
WHERE t.milliseconds >
	(SELECT AVG(t.milliseconds) FROM track t)
ORDER BY t.milliseconds DESC ;



/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines. Now use this artist to find 
which customer spent the most on this artist. For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, 
Album, and Artist tables. Note, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price
for each artist. */

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */

/* Method 1: Using CTE */
/* Method 2: : Using Recursive */


/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

/* Method 1: using CTE */
/* Method 2: Using Recursive */


/* source: www.youtube.com/@RishabhMishraOfficial */