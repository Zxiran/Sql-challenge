-- Active: 1668228158178@@127.0.0.1@3306

-- Q 51

CREATE Table world
(
    name VARCHAR(50) PRIMARY KEY,
    continent VARCHAR(50),
    area INT,
    population INT,
    gdp bigINT
);

INSERT INTO world VALUES ('Afghanistan','Asia',652230,25500100,20343000000),('Albania','Europe',28748,2831741,12960000000),('Algeria','Africa',2381741,37100000,188681000000),('Andorra','Europe',468,78115,3712000000),('Angola','Africa',1246700,20609294,100990000000);

-- Write an SQL query to report the name, population, and area of the big countries.
-- Return the result table in any order
SELECT name , population , area
from world
WHERE population >= 25000000 OR area >= 3000000;

-- Q 52

CREATE Table customer
(
    id int PRIMARY KEY,
    name VARCHAR(50),
    referee_id INT
);

INSERT INTO customer VALUES (1,'Will',null),(2,'Jane',null),(3,'Alex',2),(4,'Bill',null),(5,'Zack',1),(6,'Mark',2);

-- Write an SQL query to report the names of the customer that are not referred by the customer with id
-- = 2.
-- Return the result table in any order

SELECT name
from customer
where coalesce(referee_id,-1) !=2;

-- Q53.

create Table Customers(
    id int PRIMARY KEY,
    name VARCHAR(50)
);

CREATE Table orders
(
    id  INT PRIMARY KEY,
    cust_id int
);

INSERT into Customers VALUES (1,'Joe'),(2,'Henry'),(3,'Sam'),(4,'Max');
INSERT INTO orders VALUES (1,3) ,(2,1);
-- Write an SQL query to report all customers who never order anything.
-- Return the result table in any order.

SELECT name
from Customers
WHERE id NOT in (SELECT cust_id from orders);

-- Q54.

CREATE Table employee
(
    emp_id int PRIMARY KEY,
    team_id INT
);

INSERT INTO employee VALUES (1,8),(2,8),(3,8),(4,7),(5,9),(6,9);

-- Write an SQL query to find the team size of each of the employees.
with team as(SELECT team_id , COUNT(emp_id) as team_size
from employee
GROUP BY team_id)

SELECT e.emp_id , t.team_size
from employee e
JOIN team t
ON e.team_id = t.team_id ;

--  Q 55
CREATE TABLE person 
(
    id int PRIMARY KEY,
    name VARCHAR(50),
    ph_no VARCHAR(20)
);

CREATE Table country
(
    name VARCHAR(50),
    country_code VARCHAR(5) PRIMARY KEY
);

CREATE Table calls
(
    caller_id int,
    callee_id int,
    duration INT
);

INSERT INTO person VALUES (3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),(1,'Moncef','212-1234567'),(2,'Maroua','212-6523651'),(7,'Meir','972-1234567'),(9,'Rachel','972-0011100');

INSERT INTO country VALUES ('Peru',51),('Israel',972),('Morocco',212),('Germany',49),('Ethiopia',251);

INSERT INTO calls VALUES (1,9,33),(2,9,4),(1,2,59),(3,12,102),(3,12,330),(12,3,5),(7,9,13),(7,1,3),(9,7,1),(1,7,7);

-- A telecommunications company wants to invest in new countries. The company intends to invest in
-- the countries where the average call duration of the calls in this country is strictly greater than the
-- global average call duration
-- Write an SQL query to find the countries where this company can invest.
-- Return the result table in any order

SELECT AVG(duration) as global_avg
from calls
;

with t1 as(
    SELECT caller_id as callers_id , duration  
    from calls
    UNION
    SELECT callee_id as callers ,duration
    from calls)
    ,

    t2 as (
    SELECT  c.name , avg(duration) as avg_call_dur
    from person p
    JOIN t1
    ON t1.callers_id = p.id
    JOIN country c
    ON c.country_code = cast(LEFT(p.ph_no ,3) as signed)
    GROUP BY c.name)

SELECT name
from t2 
WHERE avg_call_dur > (SELECT AVG(duration) as global_avg from calls)
 ;

-- Q 56 
-- Already completed in set 1 (repeated question)

-- Q 57.
CREATE Table Orders
(
    order_no  INT PRIMARY KEY,
    cust_num INT
);

INSERT INTO Orders VALUES (1,1) , (2,2) ,(3,3) ,(4,3);

-- Write an SQL query to find the customer_number for the customer who has placed the largest
-- number of orders

with t1 as (
    SELECT cust_num , COUNT(*) as order_count
    from Orders
    GROUP BY cust_num),

t2 as(
    SELECT cust_num , 
    rank() over(ORDER BY order_count DESC) as rank_max_orders
    from t1)

SELECT cust_num
from t2
WHERE rank_max_orders =1
;

--  Q 58

CREATE Table cinema
(
    seat_id INT PRIMARY KEY,
    free bool
);

INSERT INTO cinema VALUES (1,1) ,(2,0) , (3,1) ,(4,1) ,(5,1) ;

-- Write an SQL query to report all the consecutive available seats in the cinema.
-- Return the result table ordered by seat_id in ascending order
with t1 as 
(SELECT seat_id , SUM(free) over(order by seat_id range between current row and 1 following) as pair_following,
SUM(free) over(order by seat_id range between 1 preceding and current row ) as pair_preceding
from cinema)

SELECT seat_id
from t1
WHERE pair_following =2 OR pair_preceding=2 ;

-- Q 59

CREATE Table salesPerson
(
    sales_id INT PRIMARY KEY,
    name VARCHAR(25),
    salary INT,
    commission_rate INT,
    hire_date DATE
);

CREATE Table company
(
    com_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE Table orders
(
    order_id INT PRIMARY KEY,
    order_date DATE,
    com_id INT,
    sales_id INT,
    amt INT
);

INSERT INTO salesPerson VALUES (1,'John',100000,6,'2006-4-1'),(2,'Amy',12000,5,'2010-5-1'),(3,'Mark',65000,12,'2008-12-25'),(4,'Pam',25000,25,'2005-1-1'),(5,'Alex',5000,10,'2007-2-3');

INSERT INTO company VALUES (1,'RED','Boston'),(2,'ORANGE','NewYork'),(3,'YELLOW','Boston'),(4,'GREEN','Austin');

INSERT INTO orders VALUES (1,'2014-1-1',3,4,10000),(2,'2014-2-1',4,5,5000),(3,'2014-3-1',1,1,50000),(4,'2014-4-1',1,4,25000);

-- Write an SQL query to report the names of all the salespersons who did not have any orders related to
-- the company with the name "RED"



SELECT name 
from salesPerson
WHERE sales_id NOT IN ( SELECT DISTINCT o.sales_id
                        from company c
                        JOIN orders o
                        ON c.com_id = o.com_id
                        WHERE c.name ='RED');
                
-- Q 60
CREATE Table triangle
(
    x int,
    y int ,
    z INT,
    constraint pk PRIMARY KEY (x,y,z)
);

INSERT INTO triangle VALUES (13,15,30) , (10,20,15);

-- Write an SQL query to report for every three line segments whether they can form a triangle.
-- Return the result table in any order

SELECT x, y,z , 
       case when (x+y>z and y+z>x and x+z>y) then 'Yes' 
       else 'No' 
       end as triangle
from triangle;














