*[Provide the date for nth occurrence of Sunday in future from given date](https://www.youtube.com/watch?v=6XQAokp4UCs&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=5&t=1s&ab_channel=AnkitBansal)*


[PostgreSQL Date Functions](https://chatgpt.com/share/67dce156-9350-800b-a91c-aed26c67c1a7) - I took help from this.

## I understood fully from a comment of a user under this video. Pasting the content of the comment.

### A lof of functions are not present in PostgreSQL, I had to create custom functions

## Input data
```sql
```

For BEGINNERS  (MYSQL) 

Prerequisites: 

1. dayofweek() :  gives the day of the week in integers- sunday(1), Monday (2) , Tuesday (3) .... Saturday (7) 

Example : select dayofweek('2024-05-16') ; output is 5 which is Thursday. 

2. date_add() : this is used to get dates when one date is known the other is at a certain interval. 

Example select date_add('2024-05-16', Interval 5 day) this adds 5 days to  the given date and returns a date. Keep in mind it requires an Interval value in day/month/year.


Now: 
Let's assume : given date is 2024-05-16 - thursday, weekday no 5.
To reach nth sunday lets say 3rd sunday. 

We will have to add to the date, 3 days (1st Sunday) + 7 days (2nd sunday) + 7 days (3rd sunday) 

Why 3 days? 
Because given day is thursday
Then friday, 
Then saturday
Then sunday(1st sunday) 
So 3 + 7 * (n-1) days
=> 3 + 7*2 days

Or we can get 3 days by

 Select  7 - dayofweek(given_date) + 1
7-> saturday's number 
Dayofweek(given_date) = 5
Total = 3 days. 

Now we have to add them together 

date_add(given_date, INTERVAL(7- dayofweek(given_date) + 1 + 7 * (n-1)) Day) 


- follow the synatx given above


Now let's put them together. 


-- Step 1: Declare and initialize variables

SET @given_date = '2024-05-16'; -- The starting date
SET @n = 3; -- The nth occurrence of Sunday we want to find

-- Step 2: Calculate the nth Sunday from the given date

SELECT DATE_ADD(
    @given_date,
    INTERVAL (7 - DAYOFWEEK(@given_date) + 1 + 7 * (@n - 1)) DAY
) AS nth_sunday;

