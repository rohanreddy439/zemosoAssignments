select * from category;
select * from film;
select * from film_list;
select * from film_category;
select * from sales_by_film_category;
select* from rental;
select * from customer;
select * from inventory;
select * from store;
select * from country;
select * from address;
select * from city;
select * from actor;
select * from film_actor;

-- 1st query
select film.title from 
film inner join film_category on film.film_id=film_category.film_id 
inner join category on film_category.category_id=category.category_id
where name='Comedy' and rating='PG-13';

-- 2nd query
select film.title,category.name 
from (rental inner join inventory on rental.inventory_id=inventory.inventory_id)
inner join film on inventory.film_id=film.film_id
inner join film_category on film.film_id=film_category.film_id
inner join category on film_category.category_id=category.category_id
where category.name='Horror'
group by film.film_id
order by count(*) desc
limit 3;

-- 3rd query
select first_name,last_name from customer
where customer_id in(
select rental.customer_id 
from (rental inner join inventory on rental.inventory_id=inventory.inventory_id)
inner join film on inventory.film_id=film.film_id
inner join film_category on film.film_id=film_category.film_id
inner join category on film_category.category_id=category.category_id
where category.name='Sports' and
 rental.customer_id in (
select customer.customer_id from
customer inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
where country.country='India'
));

-- 4th query
select Distinct customer.customer_id,customer.first_name
from (rental inner join inventory on rental.inventory_id=inventory.inventory_id)
inner join film_actor on inventory.film_id=film_actor.film_id
inner join actor on actor.actor_id=film_actor.actor_id
inner join customer on customer.customer_id=rental.customer_id
inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
where country.country='Canada';

-- 5th query
select count(*) from
film inner join film_actor on (film.film_id=film_actor.film_id)
inner join actor on(film_actor.actor_id = actor.actor_id)
where actor.first_name='SEAN' and last_name='WILLIAMS';