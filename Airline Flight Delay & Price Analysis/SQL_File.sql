use airline_data;
show tables;
desc bookings_details;

-- Update data types and normalize Flights_Details table
alter table Flights_Details
modify column flight int,
modify column flight_code VARCHAR(10),
modify column sched_dep_time TIME,
modify column dep_time TIME,
modify column dep_delay_min INT,
modify column sched_arr_time TIME,
modify column arr_time TIME,
modify column arr_delay_min INT,
modify column air_time_min INT,
modify column distance INT;

-- Update data types and normalize Customers_Details table
alter table Customers_Details
modify column cust_id INT,
modify column cust_name VARCHAR(255),
modify column city VARCHAR(255),
modify column neighbourhood VARCHAR(255),
modify column latitude DECIMAL(9,6),
modify column longitude DECIMAL(9,6);

-- Update data types and normalize Bookings_Details table
alter table Bookings_Details
modify column flight INT,
modify column flight_code VARCHAR(10),
modify column cust_id INT,
modify column stay_type VARCHAR(255),
modify column stay_price INT,
modify column flight_price INT,
modify column night_flight INT,
modify column total_number_travel INT,
modify column total_cust_listings_count INT,
modify column availability_365 INT,
modify column year INT,
modify column month INT,
modify column day INT;


-- 1. Retrieve the total number of bookings made by customers.
select count(*) as total_bookings
from Bookings_Details;

-- 2.  average flight delay in minutes.
select avg(dep_delay_min) as average_delay
from Flights_Details;

-- 3. number of customers per city.
select city, count(*) as customer_count
from Customers_Details
group by city;

-- 4  top 5 flights with the most bookings.
select flight_code, count(*) as booking_count
from Bookings_Details
group by flight_code order by booking_count desc
limit 5;

-- 5. top 10 customer details along with their corresponding flight and flight code
select c.cust_name, b.flight, b.flight_code
from Customers_Details c
inner join Bookings_Details b on c.cust_id = b.cust_id
limit 10;

-- 6. total revenue generated from bookings by city .
select city, sum(stay_price + flight_price) as total_revenue
from Bookings_Details
group by city order by total_revenue desc;

-- 7. number of bookings for each stay type.
select stay_type, count(*) as booking_count
from Bookings_Details
group by stay_type order by booking_count desc;

-- 8. flight details for flights that have availability for 365 days.
select flight, flight_code, availability_365
from Flights_Details
where availability_365 = 365;

-- 9. flight details for flights that have bookings
SELECT f.flight, f.flight_code, b.cust_id
FROM Flights_Details f
LEFT JOIN Bookings_Details b ON f.flight = b.flight;






