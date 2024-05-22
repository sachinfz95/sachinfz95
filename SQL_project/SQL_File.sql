show databases;
use sakila;

/*Task 1: The Sakila rental store management wants to know the names of all the actors in 
their movie collection. Display the first names, last names, actor IDs, and the details of the last_updated column.*/


select first_name, last_name, actor_id,last_update from actor; 
# fetched all the details of actors in their movie collection.




/*Task 2: Many actors have adopted attractive screen names, mostly at the behest of producers and directors.
 The management wants to know the following:
a.Display the full names of all actors.
b.Display the first names of actors along with the count of repeated first names.
C. Display the last name of actors along with the count of repeated last names.*/

# A. Display the full names of all actors
select concat(first_name, '  ', last_name) as Full_Name from actor; 

# B.Display the first names of actors along with the count of repeated first names.
select first_name, count(first_name) as name_count from actor group by first_name;

# C. Display the last name of actors along with the count of repeated last names.
select last_name, count(last_name) as name_count from actor group by last_name;




/*Task 3: Display the count of movies grouped by the ratings.
Sample output:	
Rating	Count of movies
G	178
R	202*/

select rating, count(*) as count_of_movies from film group by rating;





/*Task 4: Calculate and display the average rental rates based on the movie ratings.
Sample output:
Rating.   Average rental rate (in $)
PG 13.     2.3
G.         3.0 */

select rating, avg(rental_rate) as avg_rent from film group by rating;




/*Task 5: The management wants the data about replacement cost of movies. 
Replacement cost is the amount of money required to replace an existing asset 
(DVD/blue ray disc) with an equally valued or similar asset at the current market price.
a. Display the movie titles where the replacement cost is up to $9.
b. Display the movie titles where the replacement cost is between $15 and $20.
С.Display the movie titles with the highest replacement cost and the lowest rental cost.*/

#a. Display the movie titles where the replacement cost is up to $9.
select title from film where replacement_cost <= 9.0;

#b. Display the movie titles where the replacement cost is between $15 and $20.
select title from film where replacement_cost >= 15.0 AND replacement_cost <= 20.0;

#С.Display the movie titles with the highest replacement cost and the lowest rental cost
select title from film where replacement_cost = 
(select max(replacement_cost) from film) and 
rental_rate = (select min(rental_rate) from film);



/*Task 6: The management needs to know the list all the movies along with the number of actors listed for each movie.*/

select title, count(*) as actor_count from film
inner join film_actor on film.film_id = film_actor.film_id 
group by film.title order by actor_count desc;




/*Task 7: The Music of Queen and Kris Kristofferson has seen an unlikely resurgence. 
As an unintended consequence, movies starting with the letters 'K' and 'Q' have also soared in popularity. 
Display the movie titles starting with the letters 'K' and 'Q'.*/

select title from film where title like 'K%' or title LIKE 'Q%' order by title;




/*Task 8: The movie 'AGENT TRUMAN' has been a great success. Display the first names and last names of 
all actors who are a part of this movie.*/

select first_name, last_name from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film_actor.film_id = film.film_id
where film.title = 'AGENT TRUMAN';



/*Task 9: Sales has been down among the family audience with kids. 
The management wants to promote the movies that fall under the 'children' category. 
Identify and display the names of the movies in the family category.*/

select film.title from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where category.name = 'Children';



/*Task 10: Display the names of the most frequently rented movies in descending order, 
so that the management can maintain more copies of such movies.*/

select title, count(rental.rental_id) as rental_count from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by title order by rental_count desc;






/*Task 11: Calculate and display the number of movie categories where the average difference 
between the movie replacement cost and the rental rate is greater than $15.*/


select count(distinct category_id) as category_count from film_category
inner join  film on film_category.film_id = film.film_id
where (film.replacement_cost - film.rental_rate) > 15;





/* Task 12: The management wants to identify all the genres that consist of 60-70 movies. 
The genre details are captured in the category column. Display the names of these categories/genres 
and the number of movies per category/genre, sorted by the number of movies.*/


select name as genre, count(*) as movie_count from category
inner join film_category on category.category_id = film_category.category_id
group by genre having movie_count between 60 and 70 order by movie_count;


/* Task 13 Inactive customers*/

select first_name, last_name, email from customer where active = 0;


/* Task 14 high runtime */

select title , rental_rate, length from film where (length < 50 and rental_rate >3);


/* lang by count*/
select name as language, count(*) as movie_count from language
inner join film on film.language_id = language.language_id
group by language ;