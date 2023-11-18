SELECT * FROM AppleStore1
LIMIT 10

CREATE TABLE applestore_description AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4

-- EXPLORATORY DATA ANALYSIS--

--1. check for missing data in tables

SELECT count(*) FROM AppleStore1 as missing_values
WHERE ID is NULL or price is null or cont_rating is null

SELECT count(*) FROM applestore_description as missing_values
WHERE ID is NULL or track_name is NULL or app_desc is NULL 
-- no missing values.

--2. check for missing data between two tables

SELECT COUNT(DISTINCT id) as NOC
FROM AppleStore1 

SELECT COUNT(DISTINCT id) as NOC2
FROM applestore_description
-- no missing data between columns. 

-- Find out number of apps in each genre

SELECT prime_genre as genre,COUNT(id) as NOI
FROM AppleStore1
group by prime_genre

-- Find out number of paid and free apps 

SELECT
  SUM(CASE WHEN price = 0 THEN 1 ELSE 0 END) AS count_free_app,
  SUM(CASE WHEN price <> 0 THEN 1 ELSE 0 END) AS count_paid_app
FROM AppleStore1;

-- Find out number of user ratings according to different genre 

SELECT prime_genre as genre,sum(rating_count_tot) as number_of_ratings
from AppleStore1 
group by genre
ORDER by number_of_ratings DESC

-- Get an overview of apps rating

SELECT min(user_rating) as minimum_rating,
		max(user_rating) as maximum_rating,
        avg(user_rating) as average_rating
FROM AppleStore1

-- Find average rating of paid v/s free apps 

SELECT
    AVG(CASE WHEN price = 0 THEN user_rating END) AS average_free_app_rating,
    AVG(CASE WHEN price <> 0 THEN user_rating END) AS average_paid_app_rating
FROM AppleStore1

-- Find average rating according to different genre 

SELECT prime_genre as genre, avg(user_rating) as average_ratings
from AppleStore1 
group by genre
order by average_ratings desc

