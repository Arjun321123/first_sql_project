** data analysis**
-- 1. Determine whether paid apps have higher ratings or free apps 

SELECT 
	avg(CASE when price = 0 THEN user_rating end) as free_apps_rating,
    avg(CASE WHEN price <> 0 then user_rating end) as paid_app_rating
from AppleStore1
-- paid apps have better average rating. 

-- 2. Determine whether apps with more higher language support have higher rating.

select lang_num as number_of_languages,avg(user_rating) as average_rating
from AppleStore1
group by number_of_languages
ORDER by lang_num
-- we cannot see a trend by this method. 
SELECT 
	avg(case when lang_num < 10 then user_rating END) as rating_under_10,
    avg(case when lang_num BETWEEN 10 and 20 then user_rating END) as rating_between_10and20,
    avg(case when lang_num BETWEEN 21 and 30 then user_rating END) as rating_between_20and30,
    avg(case when lang_num > 30 then user_rating END) as rating_over_30
from AppleStore1

-- 3. Check genre with low rating 
SELECT prime_genre as genre, avg(user_rating) as user_rating1
from AppleStore1
GROUP by genre
ORDER BY user_rating1 asc
limit 10

-- 4. Check if there's any correlation between length of description and user rating

SELECT CASE
			when length(ad.app_desc)<500 THEN "short"
          	when length(ad.app_desc) BETWEEN 500 and 1000 THEN "medium"
            else "long"
            end as description_length,
            avg(a.user_rating) as average_rating
from AppleStore1 as a JOIN applestore_description as ad
on a.id = ad.id
GROUP by description_length
order by average_rating desc

-- 5.check the top rated app for each genre (total number of rating * user rating)

SELECT
    prime_genre AS genre,
    track_name AS top_rated_app,
    MAX(user_rating*rating_count_tot) AS max_user_rating
FROM
    AppleStore1
GROUP BY
    prime_genre;

-- 6.highest number of ratings in each genre 
SELECT
    prime_genre AS genre,
    track_name AS app,
    MAX(rating_count_tot) AS rating_count 
FROM
    AppleStore1
GROUP BY
    prime_genre
order by rating_count desc

-- 7. find the overall better app categories by weighted ratings 

SELECT
    prime_genre AS genre,
    sum(user_rating*rating_count_tot)/sum(rating_count_tot) as weighted_rating
FROM
    AppleStore1
GROUP BY
    prime_genre
order by weighted_rating desc