show TABLEs;
DROP TABLE station;
# create table CITY


create table CITY(
    id int,
    name_ varchar(17),
    country_code varchar(3),
    district varchar(20),
    population_ int
);

INSERT into CITY VALUES(6 ,'Rotterdam', 'NLD' ,'Zuid-Holland', 593321);
INSERT into CITY VALUES(3878, 'Scottsdale', 'USA', 'Arizona', 202705);
INSERT into CITY VALUES(3965, 'Corona' ,'USA' ,'California', 124966);
INSERT into CITY VALUES(3973, 'Concord', 'USA' ,'California', 121780);
INSERT into CITY VALUES(3977 ,'Cedar Rapids', 'USA', 'Iowa', 120758);
INSERT into CITY VALUES(3982 ,'Coral Springs', 'USA', 'Florida', 117549);
INSERT into CITY VALUES(4054 ,'Fairfield', 'USA', 'California', 92256);
INSERT into CITY VALUES(4058, 'Boulder', 'USA', 'Colorado', 91238);
INSERT into CITY VALUES(4061, 'Fall River', 'USA', 'Massachusetts', 90555);

SELECT * from CITY;

# Q1
# Query all columns for all American cities in the CITY table with populations larger than 100000.
# The CountryCode for America is USA.

SELECT * 
from CITY
WHERE country_code='USA' AND population_ > 100000;


# Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
# The CountryCode for America is USA

SELECT name_
from CITY
WHERE country_code='USA' AND population_ > 120000;

# Q3. Query all columns (attributes) for every row in the CITY table.

SELECT * from CITY;

# Q4. Query all columns for a city in CITY with the ID 1661.

SELECT *
from CITY
WHERE id=1661;

# Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT *
from CITY
WHERE country_code='JPN';

# Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT name_
from CITY
WHERE country_code='JPN';


#Q-7 Create table station

CREATE TABLE station(
    id int,
    city varchar(21),
    state varchar(2),
    lat_n int,
    long_w int 
);

INSERT INTO station VALUES(794 ,'Kissee Mills', 'MO' ,139 ,73
);
INSERT INTO station VALUES(824 ,'Loma Mar', 'CA', 48, 130);
INSERT INTO station VALUES(603, 'Sandy Hook', 'CT' ,72 ,148);
INSERT INTO station VALUES(478, 'Tipton', 'IN', 33, 97);
INSERT INTO station VALUES(619 ,'Arlington', 'CO', 75, 92);
INSERT INTO station VALUES(711, 'Turner', 'AR',50 ,101);
INSERT INTO station VALUES(839 ,'Slidell', 'LA', 85, 151);
INSERT INTO station VALUES(411, 'Negreet', 'LA' , 98,105);
INSERT INTO station VALUES(588, 'Glencoe', 'KY', 46 ,136);
INSERT INTO station VALUES(665, 'Chelsea', 'IA', 98, 59
);
INSERT INTO station VALUES(342, 'Chignik Lagoon' ,'AK', 103, 153);
INSERT INTO station VALUES(733, 'Pelahatchie', 'MS', 38, 28);
INSERT INTO station VALUES(441, 'Hanna City', 'IL', 50 ,136);
INSERT INTO station VALUES(811, 'Dorrance', 'KS', 102, 121);
INSERT INTO station VALUES(698, 'Albany', 'CA' ,49, 80);
INSERT INTO station VALUES(325, 'Monument' ,'KS' ,70 ,141);
INSERT INTO station VALUES(414, 'Manchester', 'MD' ,73, 37);
INSERT INTO station VALUES(113, 'Prescott', 'IA' ,39, 65);
INSERT INTO station VALUES(971, 'Graettinger' ,'IA' ,94, 150);
INSERT INTO station VALUES(266, 'Cahone', 'CO', 116 ,127);


# Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

SELECT city,id
from station
WHERE right(id,1) IN (2,4,6,8,0) 
;

# Q9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

SELECT count(city) - count(DISTINCT city) as diff
from station;

# Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
# respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
# largest city, choose the one that comes first when ordered alphabetically

# City with smallest name
SELECT city , length(REPLACE(city,' ','')) as len 
from station
order by len , city
limit 1
;

# City with the longest name
SELECT city , length(REPLACE(city,' ','')) as len 
from station
order by len desc , city
limit 1;


# Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
# cannot contain duplicates.

SELECT city 
from station
WHERE substring(lower(city),1,1) IN ('a' ,'e' ,'i','o' , 'u')
;

# Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
# contain duplicates

SELECT city 
from station
WHERE RIGHT(city,1) IN ('a' ,'e' ,'i','o' , 'u');


# Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
# contain duplicates

SELECT city 
from station
WHERE substring(lower(city),1,1) NOT IN ('a' ,'e' ,'i','o' , 'u');

# Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
# contain duplicates.


SELECT city 
from station
WHERE RIGHT(city,1) NOT IN ('a' ,'e' ,'i','o' , 'u');

# Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
# with vowels. Your result cannot contain duplicates.

SELECT city
from station
WHERE LEFT(lower(city),1) NOT IN ('a' ,'e' ,'i','o' , 'u') OR  RIGHT(city,1) NOT IN ('a' ,'e' ,'i','o' , 'u')
;

# Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
# vowels. Your result cannot contain duplicates.
SELECT city
from station
WHERE LEFT(lower(city),1) NOT IN ('a' ,'e' ,'i','o' , 'u') AND  RIGHT(city,1) NOT IN ('a' ,'e' ,'i','o' , 'u')
;


# Create product TABLE

CREATE TABLE Product
(
    product_id int,
    product_name varchar(20),
    unit_price int,
    constraint pk PRIMARY KEY (product_id)
);

INSERT into Product VALUES (1 , 'S8', 1000),
(2 ,'G4', 800),
(3 ,'iPhone' ,1400)
;

# Create table Sales
CREATE TABLE Sales
(
    seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
    quantity int,
    price int
);

INSERT INTO Sales VALUES (1, 1, 1, '2019-01-21', 2, 2000),
(1 ,2 ,2 ,'2019-02-17' ,1 ,800),
(2, 2, 3, '2019-06-02', 1, 800),
(3 ,3 ,4 ,'2019-05-13' ,2 ,2800);

SELECT * from Sales;

# Q17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
# between 2019-01-01 and 2019-03-31 inclusive.




SELECT product_id ,product_name 
from Product 
WHERE product_id NOT IN (
SELECT product_id 
from Sales
WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'
);


CREATE Table Views
(
    article_id int,
    author_id int,
    viewer_id int,
    view_date DATE
);

INSERT INTO Views VALUES (1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3 ,4, 4, '2019-07-21');

# Q18 Write an SQL query to find all the authors that viewed at least one of their own articles.
SELECT DISTINCT author_id
from Views
WHERE author_id = viewer_id;

CREATE TABLE delivery
(
    delivery_id int,
    customer_id int,
    order_date DATE,
    customer_pref_del_date DATE
);

INSERT INTO delivery VALUES (1, 1 ,'2019-08-01' ,'2019-08-02'),
(2 ,5 ,'2019-08-02', '2019-08-02'),
(3 ,1 ,'2019-08-11', '2019-08-11'),
(4,3, '2019-08-24', '2019-08-26'),
(5 ,4 ,'2019-08-21' ,'2019-08-22'),
(6 ,2, '2019-08-11' ,'2019-08-13');

SELECT 
round(
        (
        (SELECT COUNT(*)
        from delivery
        WHERE order_date = customer_pref_del_date) / COUNT(*)
        ) *100 ,
     2) as immediate_percent
from delivery;

# CREATE table ads

CREATE TABLE ads
(
    ad_id int,
    user_id int,
    action enum('Clicked' , 'Viewed' , 'Ignored'),
    constraint pk PRIMARY KEY (ad_id,user_id)
);

INSERT INTO ads VALUES (1 ,1 ,1);
INSERT INTO ads VALUES (2, 2 ,1);
INSERT INTO ads VALUES (3, 3 ,2);
INSERT INTO ads VALUES(5, 5 ,3);
INSERT INTO ads VALUES(1, 7 ,3);
INSERT INTO ads VALUES(2 ,7 ,2);
INSERT INTO ads VALUES(3, 5 ,1);
INSERT INTO ads VALUES(1 ,4 ,2);
INSERT INTO ads VALUES(2 ,11, 2);
INSERT INTO ads VALUES(1 ,2 ,1);

# Q 20 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
# Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
# tie.

--Solution 1 (without using subqueries)
SELECT ad_id , CASE WHEN SUM(case when action=1 then 1 else 0 END ) + SUM(case when action=2 then 1 else 0 END )=0
then 0
ELSE
(
    SUM(case when action=1 then 1 else 0 END ) / 
                                            (SUM(case when action=1 then 1 else 0 END )
                                            +
                                            SUM(case when action=2 then 1 else 0 END ) )
) * 100 
END
as ctr  
from ads
GROUP BY ad_id
ORDER BY ctr desc , ad_id;

--Solution 2 (using subquery)
with t1 as
(SELECT ad_id , SUM(case when action=1 then 1 else 0 END) as total_clicks ,
SUM(case when action=2 then 1 else 0 END ) as total_views
from ads
GROUP BY ad_id)

SELECT ad_id , 
CASE WHEN total_clicks !=0 then
round((total_clicks*100)/(total_clicks+total_views),2)
ELSE 0
END
as ctr
from t1
ORDER BY ctr desc , ad_id;


# Create table employee

CREATE TABLE employee
(
    emp_id int,
    team_id int,
    constraint pk PRIMARY KEY (emp_id)
);

INSERT into employee VALUES (1, 8),
(2 ,8),
(3 ,8),
(4 ,7),
(5 ,9),
(6 ,9);

# Q21 Write an SQL query to find the team size of each of the employees.

select emp_id , COUNT(*) over (partition by team_id  ) as team_size
from employee;

# CREATE table countries

CREATE TABLE countries
(
    country_id int PRIMARY KEY,
    country_name varchar(20)
);

INSERT INTO countries VALUES (2, 'USA'),
(3, 'Australia'),
(7 ,'Peru'),
(5 ,'China'),
(8 ,'Morocco'),
(9 ,'Spain');

CREATE Table weather(
    country_id int,
    weather_state int,
    day DATE,
    constraint pk PRIMARY KEY (country_id , day)
);

INSERT INTO weather VALUES (2, 15, '2019-11-01'),
(2, 12, '2019-10-28'),
(2, 12, '2019-10-27'),
(3, -2, '2019-11-10'),
(3, 0 ,'2019-11-11'),
(3, 3, '2019-11-12'),
(5, 16, '2019-11-07'),
(5, 18, '2019-11-09'),
(5, 21, '2019-11-23'),
(7, 25, '2019-11-28'),
(7, 22, '2019-12-01'),
(7, 20, '2019-12-02'),
(8, 25, '2019-11-05'),
(8, 27, '2019-11-15'),
(8, 31, '2019-11-25'),
(9, 7, '2019-10-23'),
(9, 3, '2019-12-23');

# Q22 Write an SQL query to find the type of weather in each country for November 2019.
# The type of weather is:
# ● Cold if the average weather_state is less than or equal 15,
# ● Hot if the average weather_state is greater than or equal to 25, and
# ● Warm otherwise.
# Return result table in any order


with t1 as (SELECT c.country_id , c.country_name , w.weather_state , w.day 
from countries c
JOIN weather w 
ON c.country_id = w.country_id
WHERE w.day  BETWEEN '2019-11-01' AND '2019-11-30'
)
SELECT country_id , country_name ,
CASE WHEN avg(weather_state) <=15 then 'Cold' 
     WHEN avg(weather_state) >=25 then 'Hot'
     ELSE 'Warm'
     END as weather_type
from t1
GROUP BY country_id , country_name;

# Q 23

# create table prices

CREATE TABLE prices
(
    product_id int,
    start_date date,
    end_date date,
    price int,
    constraint pk PRIMARY KEY (product_id ,start_date , end_date)
);

INSERT INTO prices VALUES (1 ,'2019-02-17' ,'2019-02-28' ,5),
(1, '2019-03-01' ,'2019-03-22', 20),
(2, '2019-02-01' , '2019-02-20' ,15),
(2 , '2019-02-21' ,'2019-03-31',30);

CREATE Table unitsSold
(
    product_id int,
    purchase_date date,
    units int
);

INSERT INTO unitsSold VALUES (1,'2019-02-25',100),
(1 ,'2019-03-01' ,15),
(2 ,'2019-02-10' , 200),
(2 ,'2019-03-22' ,30);


# Q 23 Write an SQL query to find the average selling price for each product. average_price should be
# rounded to 2 decimal places.
# Return the result table in any order

SELECT p.product_id , 
       round( SUM(us.units*p.price)/SUM(units) ,2) as avg_price
from prices p
JOIN unitsSold us
ON p.product_id = us.product_id AND us.purchase_date BETWEEN p.start_date AND p.end_date 
GROUP BY p.product_id;

                         
#Q 24
# Write an SQL query to report the first login date for each player.
# Return the result table in any order

CREATE TABLE activity(
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    constraint pk PRIMARY KEY (player_id , event_date)
);

INSERT INTO activity VALUES (1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02' ,6),
(2, 3, '2017-06-25', 1),
(3 , 1 , '2016-03-02', 0),
(3 ,4 ,'2018-07-03' ,5);


with t1 as (SELECT player_id,event_date , rank() over(partition by player_id ORDER BY event_date) as first_login
from activity)

SELECT player_id , event_date 
from t1
WHERE first_login =1
;

# Q 25) Write an SQL query to report the device that is first logged in for each player.
# Return the result table in any order
with t1 as (SELECT player_id,device_id,event_date, rank() over(partition by player_id ORDER BY event_date) as first_login
from activity)

SELECT player_id , device_id 
from t1
WHERE first_login =1
;

# Q 26

CREATE TABLE products(
    product_id int PRIMARY KEY,
    product_name varchar(25),
    product_category varchar(20)
);



INSERT INTO products VALUES(1,'Leetcode Solutions' ,'Book');
INSERT INTO products VALUES(2,'Jewels of Stringology','Book') , 
(3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit' , 'T-shirt');

CREATE Table orders(
    product_id int,
    order_date DATE,
    unit int
);

INSERT INTO orders VALUES (1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17' ,2),
(3, '2020-02-24' ,3),
(4, '2020-03-01' ,20),
(4, '2020-03-04' ,30),
(4, '2020-03-04' ,60),
(5, '2020-02-25' ,50),
(5, '2020-02-27' ,50),
(5, '2020-03-01' ,50);


# Q 26) Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
# and their amount.

SELECT p.product_name , sum(o.unit) as total_unit
from products p
JOIN orders o
ON p.product_id = o.product_id AND MONTH(order_date) =2
GROUP BY p.product_name
HAVING sum(o.unit) >=100
;


# Q 27

CREATE TABLE users(
    user_id int PRIMARY KEY,
    name varchar(20),
    mail varchar(50)
);

INSERT INTO users values (1, 'Winston' ,'winston@leetcode.com'),
(2 ,'Jonathan', 'jonathanisgreat'),
(3 ,'Annabelle', 'bella-@leetcode.com'),
(4 ,'Sally', 'sally.come@leetcode.com'),
(5 ,'Marwan', 'quarz#2020@leetcode.com'),
(6 ,'David', 'david69@gmail.com'),
(7 ,'Shapiro', '.shapo@leetcode.com');


# Q 27 Write an SQL query to find the users who have valid emails.
# A valid e-mail has a prefix name and a domain where:
# ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
# '_', period '.', and/or dash '-'. The prefix name must start with a letter.
# ● The domain is '@leetcode.com'.
# Return the result table in any order

SELECT * 
from users
WHERE mail REGEXP '^[a-zA-Z]{1}[a-zA-z0-9_\/\.\-]+@leetcode.com';


# Q 28

CREATE TABLE customers(
    cust_id int PRIMARY KEY,
    name varchar(25),
    country varchar(25)
);


#  create table product

CREATE TABLE product(
    product_id int PRIMARY KEY,
    description varchar(20),
    price int
);

CREATE Table orders(
    order_id int PRIMARY KEY,
    cust_id int,
    product_id INT,
    order_date DATE,
    quantity INT
);

INSERT into customers VALUES(1,'Winston', 'USA'),(2,'Jonathan','Peru') ,(3,'Moustafa','Egypt');

INSERT INTO product VALUES(10,'LC phone' ,300), (20,'LC t-shirt' , 10) ,(30,'LC Book' , 45),
(40,'LC Keychain' ,2);


INSERT INTO orders VALUES (1, 1 ,10, '2020-06-10', 1),
(2 ,1 ,20,'2020-07-01', 1),
(3 ,1 ,30, '2020-07-08', 2),
(4 ,2 ,10, '2020-06-15', 2),
(5 ,2 ,40, '2020-07-01', 10),
(6 ,3 ,20, '2020-06-24', 2),
(7 ,3 ,30, '2020-06-25', 2),
(9 ,3 ,30, '2020-05-08', 3);

# Q 28) Write an SQL query to report the customer_id and customer_name of customers who have spent at
# least $100 in each month of June and July 2020

SELECT c.cust_id , c.name , SUM(p.price * o.quantity) 
from orders o
JOIN product p
ON (
    p.product_id = o.product_id AND 
    MONTH(o.order_date) IN (6,7) AND 
    Year(o.order_date) = 2020
    )
JOIN customers c 
ON c.cust_id = o.cust_id
GROUP BY c.cust_id , c.name 
HAVING SUM(p.price * o.quantity) >=100;


# Q 29

# Table tvprogram
CREATE TABLE tvprogram(
    program_date Date,
    content_id int,
    channel varchar(20),
    constraint pk PRIMARY KEY (program_date ,content_id)
);

INSERT INTO tvprogram VALUES ('2020-06-10 08:00', 1 ,'LC-Channel'),
('2020-05-11 12:00' ,2, 'LC-Channel'),
('2020-05-12 12:00', 3, 'LC-Channel'),
('2020-05-13 14:00', 4, 'Disney Ch'),
('2020-06-18 14:00', 4, 'Disney Ch'),   
('2020-07-15 16:00', 5,'Disney Ch');


#content TABLE

CREATE TABLE content(
    content_id int PRIMARY KEY,
    title varchar(50),
    kids_content enum('Y','N'),
    content_type varchar(20)
);

INSERT into content VALUES(1, 'Leetcode Movie', 'N' ,'Movies'),
(2 ,'Alg. for Kids', 'Y', 'Series'),
(3 ,'Database Sols', 'N' ,'Series'),
(4, 'Aladdin', 'Y' ,'Movies'),
(5 ,'Cinderella', 'Y' ,'Movies');


# Q 29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.

SELECT title
from content c
JOIN tvprogram t
ON t.content_id = c.content_id
WHERE 
        kids_content =1 AND 
        content_type = 'Movies' 
        AND Year(t.program_date) =2020 AND MONTH(t.program_date) = 6;


# Q 30
# Q 31 

# Q 32

CREATE TABLE employees(
    id int PRIMARY KEY,
    name varchar(50)
);

CREATE Table employeeuni(
    id int,
    unique_id int,
    constraint pk PRIMARY KEY (id, unique_id)
);

INSERT INTO employees VALUES (1,'Alice'),(7,'Bob'),(11,'Meir'),(90,'Winston'),(3,'Jonathan');

INSERT INTO employeeuni VALUES(3,1),(11,2),(90,3);

# Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
# show null.
select e.name , euid.unique_id
from employees e
LEFT JOIN employeeuni euid
ON e.id = euid.id;

# Q33.
CREATE TABLE users(
    id int PRIMARY KEY,
    name varchar(25)
);

CREATE Table rides(
    id int PRIMARY KEY,
    user_id int,
    distance INT
);

INSERT into users VALUES (1,'Alice'),(2,'Bob'),(3,'Alex'),(4,'Donald'),(7,'Lee'),(13,'Jonathan'),(19,'Elvis');


INSERT INTO rides VALUES (1,1,120),(2,2,317),(3,3,222),(4,7,100),(5,13,312),(6,19,50),(7,7,120),(8,19,400),(9,7,230);

# Q 33 Write an SQL query to report the distance travelled by each user.
# Return the result table ordered by travelled_distance in descending order, if two or more users
# travelled the same distance, order them by their name in ascending order
SELECT u.name , coalesce(SUM(r.distance),0) as total_distance
from users u
LEFT JOIN rides r
ON u.id=r.user_id
GROUP BY u.name
ORDER BY total_distance DESC, u.name;

# Q34.
-- CREATE TABLE Products(
--     product_id int PRIMARY KEY,
--     product_name varchar(50),
--     product_category varchar(50)
-- );

-- CREATE Table Orders(
--     product_id int,
--     order_date date,
--     unit int
-- );

-- INSERT into Products VALUES (1,'Leetcode Solutions','Book'),(5,'Leetcode Kit','T-shirt'),(3,'HP','Laptop'),(4,'Lenovo','Laptop'),(2,'Jewels of Stringology','Book');

# Q35

CREATE TABLE movies(
    movie_id int PRIMARY KEY,
    title varchar(50)
);

CREATE Table Users(
    user_id int PRIMARY KEY,
    name VARCHAR(50)
);

CREATE Table movierating(
    movie_id int,
    user_id int,
    rating int,
    created_at DATE,
    constraint pk PRIMARY KEY (movie_id, user_id)
);

INSERT INTO movies VALUES (1,'Avengers'),(3,'Joker'), (2,'Frozen 2');

INSERT into Users VALUES (1,'Daniel'),(2,'Monica'),(3,'Maria'),(4,'James');

INSERT into movierating VALUES (1,1,3,'2020-01-12'),(1,2,4,'2020-02-11'),(1,3,2,'2020-02-12'),(1,4,1,'2020-01-01'),(2,1,5,'2020-02-17'),(2,2,2,'2020-02-01'),(2,3,2,'2020-03-01'),(3,1,3,'2020-02-22'),(3,2,4,'2020-02-25');

-- Q 35 Write an SQL query to:
-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
-- return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return
-- the lexicographically smaller movie name.

SELECT u.name , COUNT(*) as rating_given
from movierating mr
JOIN Users u
ON u.user_id = mr.user_id
GROUP BY u.user_id
ORDER BY rating_given desc, u.name
limit 1;


SELECT m.title, AVG(rating) as avg_rating
from movierating mr
JOIN movies m
ON mr.movie_id = m.movie_id
WHERE month(created_at) = 2 AND year(created_at) =2020
GROUP BY m.title
ORDER BY avg_rating desc , m.title
limit 1;

# 36 Repeated question

# 37 Repeated question

# 38 

CREATE TABLE departments
(
    id int PRIMARY KEY,
    name varchar(50)
);

CREATE Table students
(
    id int PRIMARY KEY,
    name VARCHAR(50),
    depart_id int
);

INSERT INTO departments VALUES (1,'Electrical Engineering'),(7,'Computer Engineering'),(13,'Business Administration');

INSERT INTO students VALUES 
(23,'Alice',1),(1,'Bob',7),(5,'Jennifer',13),(2,'John',14),(4,'Jasmine',77),(3,'Steve',74),(6,'Luis',1),(8,'Jonathan',7),(7,'Daiana',33),(11,'Madelynn',1);

#  Q 38 Write an SQL query to find the id and the name of all students who are enrolled in departments that no
# longer exist

SELECT id , name
from students 
WHERE depart_id NOT IN (SELECT id from departments);

# Q 39

CREATE TABLE calls(
    from_id int,
    to_id int,
    duration int
);

INSERT INTO calls VALUES (1,2,59),(2,1,11),(1,3,20),(3,4,100),(3,4,200),(3,4,200),(4,3,499);

-- Write an SQL query to report the number of calls and the total call duration between each pair of
-- distinct persons (person1, person2) where person1 < person2.

SELECT case when from_id < to_id then from_id 
       else to_id
       end as person1,
       CASE when from_id > to_id then from_id 
       else to_id
       end as person2, 
       count(*) as call_count,
       sum(duration) as total_dur       
from calls
GROUP BY person1 ,person2; 

-- Q 40. Repeated question

-- Q 41 

CREATE Table Warehouse
(
    name VARCHAR(50),
    product_id int,
    units int,
    constraint pk PRIMARY KEY (name,product_id)
);

CREATE Table products
(
    product_id int PRIMARY KEY,
    product_name VARCHAR(40),
    width int,
    length int,
    height INT
);

INSERT INTO Warehouse VALUES ('LCHouse1',1,1),('LCHouse1',2,10),('LCHouse1',3,5),('LCHouse2',1,2),('LCHouse2',2,2),('LCHouse3',4,1);

INSERT INTO products VALUES (1,'LC-TV',5,50,40),(2,'LC-KeyChain',5,5,5),(3,'LC-Phone',2,10,10),(4,'LC-T-Shirt',4,10,20);

-- Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
-- warehouse
SELECT  w.name as warehouse_name , 
        SUM(p.width*p.length*p.height*w.units) as volume
from Warehouse w
JOIN products p
ON p.product_id = w.product_id 
GROUP BY w.name;

-- Q 42 
CREATE Table sales
(
    sale_date date,
    fruit ENUM('apples', 'oranges'),
    sold_num INT,
    constraint pk PRIMARY KEY (sale_date,fruit)
);

INSERT INTO sales VALUES ('2020-05-01','apples',10),('2020-05-01','oranges',8),('2020-05-02','apples',15),('2020-05-02','oranges',15),('2020-05-03','apples',20),('2020-05-03','oranges',0),('2020-05-04','apples',15),('2020-05-04','oranges',16);

-- Write an SQL query to report the difference between the number of apples and oranges sold each day.
-- Return the result table ordered by sale_date

with t1 as (
            SELECT sale_date, 
            (LAG(sold_num) over(partition by sale_date ORDER BY sale_date) - sold_num) as diff
            from sales)
SELECT * 
from t1
WHERE diff IS NOT NULL
;

-- Q43.
CREATE Table activity
(
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    constraint pk PRIMARY KEY (player_id , event_date)
);

INSERT into activity VALUES (1,2,'2016-03-01',5),(1,2,'2016-03-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5); 

with t1 as(
SELECT player_id ,Datediff(event_date ,Lag(event_date) over(partition by player_id)) as days_diff  
from activity
)
SELECT  sum(case when days_diff =1 then 1 else 0 end )/count(DISTINCT player_id) as fraction
from t1
;

-- Q 44

CREATE TABLE employee
(   
    id int PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(20),
    manager_id INT
);

INSERT INTO employee VALUES (101,'John','A',NULL),(102,'Dan','A',101),(103,'James','A',101),(104,'Amy','A',101),(105,'Anne','A',101),(106,'Ron','B',101);

SELECT * from employee;

-- Q 45
CREATE Table student 
(
    stu_id int PRIMARY KEY,
    stu_name VARCHAR(50),
    gender VARCHAR(2),
    dept_id INT
);

CREATE Table dept
(
    dept_id int PRIMARY KEY,
    dept_name VARCHAR(20)
);

INSERT INTO student VALUES (1,'Jack','M',1),(2,'Jane','F',1),(3,'Mark','M',2);

INSERT into dept VALUES (1,'Engineering'),(2,'Science'),(3,'Law');

-- Write an SQL query to report the respective department name and number of students majoring in
-- each department for all departments in the Department table (even ones with no current students).
-- Return the result table ordered by student_number in descending order. In case of a tie, order them by
-- dept_name alphabetically.

SELECT d.dept_name ,count(s.stu_id) 
from student s
RIGHT JOIN dept d
ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Q 46

CREATE Table customer
(
    cust_id int,
    prod_key INT
);

CREATE Table product(
    prod_key INT PRIMARY KEY 
);
 INSERT into customer VALUES (1,5),(2,6),(3,5),(3,6),(1,6) ;
 

 insert into product VALUES (5), (6);

-- Write an SQL query to report the customer ids from the Customer table that bought all the products in
-- the Product table.
-- Return the result table in any order

with t1 as (
    SELECT cust_id , count(DISTINCT prod_key) total_prod_key 
    from customer
    group by cust_id)

SELECT cust_id 
from t1
WHERE total_prod_key IN (SELECT COUNT(*) from product); 

--  Q 47

CREATE Table project
(
    project_id int,
    employee_id int,
    constraint pk PRIMARY KEY (project_id , employee_id)
);

CREATE Table Employee
(
    emp_id int PRIMARY KEY,
    name VARCHAR(50),
    exp_yrs INT
);

INSERT INTO project VALUES (1,1),(1,2),(1,3),(2,1),(2,4);

INSERT INTO Employee VALUES (1,'Khaled',3),(2,'Ali',2),(3,'John',3),(4,'Doe',2);

-- Write an SQL query that reports the most experienced employees in each project. In case of a tie,
-- report all employees with the maximum number of experience years.
-- Return the result table in any order

with t2 as(
SELECT project_id ,emp_id , rank() over(partition by project_id order by exp_yrs DESC) as highest_xp
from (  
    SELECT p.project_id ,e.*
    from project p
    JOIN Employee e
    ON p.employee_id = e.emp_id) as t1)

SELECT project_id , emp_id 
from t2
WHERE highest_xp =1
; 


-- Q 48

CREATE Table Books
(
    book_id int PRIMARY KEY,
    name varchar(50),
    avail_from DATE
);

CREATE Table orders
(
    order_id int PRIMARY KEY,
    book_id INT ,
    qty INT,
    dispatch_date DATE
);

INSERT INTO Books VALUES (4,'"13 Reasons Why"','2019-06-01'),(5,'"The Hunger Games"','2008-09-21'),(1, '"Kalila And Demna"', '2010-01-01') ,(2,'"28 Letters"','2012-05-12'),(3,'"The Hobbit"','2019-06-10');
INSERT into orders VALUES (1,1,2,'2018-07-26'),(2,1,1,'2018-11-05'),(3,3,8,'2019-06-11'),(4,4,6,'2019-06-05'),(5,4,5,'2019-06-20'),(6,5,9,'2009-02-02'),(7,5,8,'2010-04-13');

-- Write an SQL query that reports the books that have sold less than 10 copies in the last year,
-- excluding books that have been available for less than one month from today. Assume today is
-- 2019-06-23.

SELECT book_id , SUM(qty) 
from orders
GROUP BY book_id
HAVING SUM(qty)<10;

--Q 49
CREATE Table enrollments
(
    stu_id int,
    course_id int,
    grade int,
    constraint pk PRIMARY KEY (stu_id , course_id)
);
insert into enrollments VALUES (2,2,95),(2,3,95),(1,1,90),(1,2,99),(3,1,80),(3,2,75),(3,3,82);

-- Write a SQL query to find the highest grade with its corresponding course for each student. In case of
-- a tie, you should find the course with the smallest course_id.

with t1 as
(SELECT stu_id , course_id ,grade, row_number() over(partition by stu_id ORDER BY grade DESC , course_id ) as max_grade 
from enrollments)

SELECT stu_id , course_id , grade 
from t1
WHERE max_grade =1
;

-- Q 50




CREATE Table matches
(
    match_id int PRIMARY KEY,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT
);


CREATE TABLE players 
(
    player_id int,
    grp_id INT
);



INSERT INTO players VALUES (15,1),(25,1),(30,1),(45,1),(10,2),(35,2),(50,2),(20,3),(40,3);

INSERT INTO matches VALUES (1,15,45,3,0) ,(2,30,25,1,2) , (3,30,15,2,0) , (4,40,20,5,2) ,(5,35,50,1,1);

-- Q 50) The winner in each group is the player who scored the maximum total points within the group. In the
-- case of a tie, the lowest player_id wins.

SELECT first_player as players , first_score as scores
from matches
UNION
SELECT second_player , second_score 
from matches

;
with player_scores as (
    SELECT player_id , sum(scores) as total_score
    from (
            SELECT first_player as player_id , first_score as scores
            from matches
            UNION
            SELECT second_player , second_score 
            from matches
        ) t1
    GROUP BY player_id
),
    player_grp_rank as (
                        SELECT p.grp_id , p_s.player_id, 
                        row_number() over(partition by p.grp_id ORDER BY p_s.total_score DESC , p_s.player_id ) player_rank 
                        from player_scores p_s
                        JOIN players p
                        ON p_s.player_id = p.player_id
                    )

SELECT grp_id , player_id 
from player_grp_rank
WHERE player_rank =1
;

