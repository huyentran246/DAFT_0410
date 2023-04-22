select * from my_new_database.applestore2;

# 1. What are the different genres?
select prime_genre as genres from my_new_database.applestore2;

# 2. Which is the genre with the most apps rated?
select prime_genre as genre, rating_count_tot as rated_number from my_new_database.applestore2
order by rating_count_tot desc limit 1;

# 3. Which is the genre with most apps?
select prime_genre as genre, count(prime_genre) as number_of_apps
from my_new_database.applestore2
group by prime_genre
order by count(prime_genre) desc limit 1;

# 4. Which is the one with least?
select count(prime_genre) as number_of_app, prime_genre as genre from my_new_database.applestore2
group by prime_genre
order by count(prime_genre) asc limit 1;

# 5. Find the top 10 apps most rated.
select track_name as app, rating_count_tot as rated_number from my_new_database.applestore2
order by rating_count_tot desc limit 10;

# 6. Find the top 10 apps best rated by users.
select track_name as app, user_rating from my_new_database.applestore2
order by user_rating desc limit 10;

# 7. Take a look at the data you retrieved in question 5. Give some insights.
select rating_count_tot, user_rating, track_name, prime_genre, price from my_new_database.applestore2
order by rating_count_tot desc limit 10;

# 8. Take a look at the data you retrieved in question 6. Give some insights.
select rating_count_tot, user_rating, track_name, prime_genre, price from my_new_database.applestore2
order by user_rating desc limit 10;

# 9. Now compare the data from questions 5 and 6. What do you see?
# * The apps with most rated in total don't have the best rated votes from users, 
# 	we can see that the most rated apps in total are usually free while the most rated apps from users aren't. 
#   Obviuously when someting is free, you will get a huge number of users.
# * Most of the apps that win both the number of users and the most rated from users are Games. It's very challenging when a company goes to 
#   this field, the competition is very high, perhaps that's the reason why they make best games.
# * People nowadays do care about their health, they spent time to vote to help the companies that make Health & Fitness apps
#  	improve their performances. Why are the Health Health & Fitness apps usually free? The companies make profit from the advertisements. 

# 10. How could you take the top 3 regarding both user ratings and number of votes?
select track_name, prime_genre, user_rating, rating_count_tot from my_new_database.applestore2
where user_rating = 5
order by rating_count_tot desc limit 3; 

# 11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve.
# What is your conclusion?
select track_name, price, rating_count_tot, user_rating, prime_genre,
	case when price = 0 then "Free"
		 when price <= 3 then "Cheap"
         else "Expensive"
	end as price_category
from my_new_database.applestore2
order by rating_count_tot desc;

# I classify the price to see more detail, for the price less than or equel to 3 dollars per month I assume that it's cheap, 
# more than 3 dollars it's expensive. Globally people do care about the price of an app as we can see the apps with most rated 
# (means a huge number of users) with most rated are free or cheap.



