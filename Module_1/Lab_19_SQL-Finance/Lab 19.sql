# 1. From the order_items table, find the price of the highest priced order and lowest price order.

select * from olist.order_items;

select order_id, price as highest_price from olist.order_items
order by price desc limit 1;

select order_id, price as lowest_price from olist.order_items
order by price asc limit 1;

# 2. From the order_items table, what is range of the shipping_limit_date of the orders?

select min(shipping_limit_date) as Shipping_from, max(shipping_limit_date) as Shipping_until from olist.order_items;

# 3. From the customers table, find the states with the greatest number of customers.
select customer_state, count(customer_state) as number_of_customers from olist.customers
group by customer_state
order by count(customer_state) desc limit 1;

# 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
select * from olist.customers;

select customer_city as city, count(customer_city) as customers_number from olist.customers
where customer_state = 'SP'
group by customer_city
order by count(customer_city) desc limit 1;

# 5. From the closed_deals table, how many distinct business segments are there (not including null)?
select * from olist.closed_deals;

select count(distinct business_segment) as business_segment_number from olist.closed_deals
where business_segment is not null;

# 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and 
# find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
select business_segment, count(*) as duplicate_times, sum(declared_monthly_revenue) from olist.closed_deals
group by business_segment
having count(*) > 1
order by sum(declared_monthly_revenue) desc limit 3;

# 7. From the order_reviews table, find the total number of distinct review score values.
select * from olist.order_reviews;

select count(distinct review_score) as total_distinct_values from olist.order_reviews;


# 8. In the order_reviews table, create a new column with a description that corresponds to each number category 
# for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
select review_score,
		case when review_score = 1 then "very poor"
			when review_score = 2 then "poor"
			when review_score = 3 then "medium"
			when review_score = 4 then "high"
			else "very high"
		end as descriptions
from olist.order_reviews
group by review_score
order by count(review_score) desc;


# 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.

select review_score as review_value, count(*) as times_occur from olist.order_reviews
group by review_score
order by count(*) desc limit 1;