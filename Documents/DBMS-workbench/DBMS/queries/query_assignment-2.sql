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
select * from staff;
select * from payment;

-- 1st query
select count(*) from
film inner join film_category on (film.film_id=film_category.category_id)
inner join category on (category.category_id=film_category.category_id)
where category.name='Documentary' and film.special_features like 'Deleted Scenes';

-- 2nd query
select count(distinct inventory.film_id) 
from inventory inner join film on inventory.film_id=film.film_id
inner join film_category on film.film_id=film_category.film_id
where film_category.category_id=(select category_id from category where name='Sci-Fi')
and inventory.store_id in (
select store_id from store where manager_staff_id in(
select staff_id from staff where first_name='Jon')
);

-- 3rd query
select count(payment_id)
from payment inner join rental on (rental.rental_id=payment.rental_id)
inner join inventory on (inventory.inventory_id=rental.inventory_id)
inner join film_category on inventory.film_id=film_category.film_id
inner join category on film_category.category_id=category.category_id
where category.name='Animation';

-- 4th query
select category.name from  rental inner join inventory on (rental.inventory_id = inventory.inventory_id)
inner join film_category on (inventory.film_id=film_category.film_id) 
inner join category on (film_category.category_id = category.category_id)
where rental.customer_id IN
( select customer_id from customer where first_name='PATRICIA' and last_name='JOHNSON')
group by category.name order by count(*) DESC LIMIT 3;

-- 5th query
select count(*) from  rental inner join inventory on (rental.inventory_id = inventory.inventory_id)
inner join film on (inventory.film_id=film.film_id) where
film.rating='R' and rental.customer_id in 
( select customer_id from customer where first_name='SUSAN' and last_name='WILSON');
