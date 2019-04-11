USE sakila;
select first_name, last_name
from actor
where actor_id;

select * from actor;
-- -- -- -- -- -- -- -- -- -- -- --

select actor_id, concat(first_name, ',' ,last_name) as 'actor name' from actor;
-- -- -- -- -- -- -- -- -- -- -- - -- - -- -- -- -- -
SELECT actor_id,first_name, last_name
from actor
WHERE first_name = "Joe";

SELECT actor_id,first_name, last_name
from actor
WHERE last_name like('%GEN%');
-- 2c -- -- -- -- -- 
SELECT actor_id, last_name,first_name 
from actor 
WHERE last_name  like ('%LI%') 
order by last_name,first_name;
-- 2d -------------------------------------------------- --
select country_id , country
from country
where country in ('Afghanistan','Bangladesh','china');
-- -3a - - - - - - - - - - - - - 
ALTER TABLE actor
ADD COLUMN description BLOB; 
-- -- -- -- -- -- 3b
alter table actor
drop column description; 

-- 4a -----------------------------

SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;
-- ---------4b------------
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1; 
-- 4c------------------------------------
update actor
set first_name = groucho
where actor_id = 172; 
-- 4d---------------------
update actor
set first_name = "Harpo"
where actor_id = 172; 

update actor
set first_name = "GROUCHO"
where actor_id = 172; 
-- 5A --------
describe sakila.address;
-- 6a -----------
SELECT first_name,last_name,address.address
FROM staff
JOIN address
on staff_id;
-- 6b---------------
SELECT staff_id,
(SELECT sum(amount) FROM payment
WHERE payment.staff_id = staff.staff_id ) AS 'total rental'
FROM staff;
-- 6c------------------------------
SELECT film.title, COUNT(actor_id) as 'Actors'
FROM film_actor 
join film
WHERE film.film_id = film_actor.film_id
group by film.title;
-- 6d ----------------------
SELECT title, COUNT(inventory.film_id) as 'total film'
FROM inventory 
join film
WHERE film.film_id = inventory.film_id and title = 'Hunchback Impossible'
group by film.title;
-- 6e-------------------------------
SELECT customer.last_name, sum(amount) as 'Customer'
FROM payment
join customer
WHERE customer.customer_id= payment.customer_id
group by last_name;
-- 7a---------------------------------------

SELECT  title
FROM film
WHERE title  LIKE 'K%'or title like 'Q%' and language_id in
(
select language_id
from language
where name = 'English' 
);
-- 7b ------------------------



select first_name, last_name
from actor
where actor_id in (
	select actor_id
	from film_actor
	where film_id in (
		select film_id
		from film
		where title = 'Alone Trip')  

 );
-- 7c---------------------------------------
select first_name, last_name, email
from customer
inner join address on address.address_id = customer.address_id
inner join city on city.city_id
inner join country on country.country_id
where country.country = 'Canada';
-- 7d----------------------------------

select title
from film
inner join film_category on  film_category.film_id = film.film_id
inner join category on film_category.film_id = category.category_id
where name = 'Family';
-- 7e ------------------------------------------------------------------
select title, count(rental.rental_id)
from film
inner join inventory on  film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
order by count(rental.rental_id) desc;
--  7f----------------------------------------
select store.store_id , sum(payment.amount) as 'total' 
from payment
inner join rental on payment.rental_id = rental.rental_id
inner join inventory on  inventory.inventory_id = rental.inventory_id
inner join store on inventory.store_id = store.store_id;

--  7g---------------------------------
select store.store_id, city.city_id, country.country
from store
inner join address on address.address_id = store.address_id
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.country_id;
-- 7h------------------------------------------------------
create view movie_total as -- 8A----------
select category.name, sum(payment.amount)
from category
inner join film_category on  film_category.category_id = category.category_id
inner join inventory on inventory.film_id = film_category.film_id
inner join rental on rental.inventory_id = inventory.inventory_id
inner join payment on payment.rental_id = rental.rental_id
group by category.name
order by sum(payment.amount) desc limit 5;
-- 8b---------------------------------------------------
select * from movie_total; 
-- 8c------------------
DROP VIEW movie_total;

select * from category;
select * from film_category;
select * from inventory;
select * from rental;
select * from payment
