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

-- Q 62

CREATE Table actorDirector
(
    actor_id INT,
    director_id INT,
    time_stamp INT PRIMARY KEY
);

-- Q 63
CREATE Table sales
(
    sale_id INT,
    prd_id INT,
    year INT,
    qty INT,
    price INT,
    constraint pk PRIMARY KEY (sale_id ,year)
);

CREATE Table product
(
    prod_id INT PRIMARY KEY,
    prod_name VARCHAR(25)
);

INSERT INTO sales VALUES (1,100,2008,10,5000),(2,100,2009,12,5000),(7,200,2011,15,9000);

INSERT INTO product VALUES (100,'Nokia'),(200,'Apple'),(300,'Samsung');

-- Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table.
-- Return the resulting table in any order.
SELECT p.prod_name , s.year , s.price
from product p
JOIN sales s
ON p.prod_id = s.prd_id
;

-- Q 64

CREATE TABLE project
(
    project_id INT,
    emp_id INT,
    constraint pk PRIMARY KEY (project_id , emp_id)
);

CREATE Table employee
(
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    exp_yrs INT
);

INSERT INTO project VALUES (1,1),(1,2),(1,3),(2,1),(2,4);

INSERT INTO employee VALUES (1,'Khaled',3),(2,'Ali',2),(3,'John',1),(4,'Doe',2);

-- Write an SQL query that reports the average experience years of all the employees for each project,
-- rounded to 2 digits

SELECT p.project_id , 
       round(avg(e.exp_yrs), 2) as avg_xp_yrs
from project p
JOIN employee e
ON p.emp_id = e.emp_id
GROUP BY p.project_id
;

-- Q 65
CREATE Table Product
(
    prod_id INT PRIMARY KEY,
    prod_name VARCHAR(50),
    unit_price INT

);

CREATE Table Sales
(
    seller_id INT,
    prod_id INT,
    buyer_id INT,
    sale_date DATE,
    qty INT,
    price INT
);
INSERT INTO Product VALUES (1,'S8',1000),(2,'G4',800),(3,'iPhone',1400);
INSERT INTO Sales VALUES (1,1,1,'2019-01-21',2,2000),(1,2,2,'2019-02-17',1,800),(2,2,3,'2019-06-02',1,800),(3,3,4,'2019-05-13',2,2800);

-- Write an SQL query that reports the best seller by total sales price, If there is a tie, report them all.
-- Return the result table in any order

with t1 as(
    SELECT seller_id , SUM(price) as total_amt
    from Sales
    GROUP BY seller_id),
t2 as (
    SELECT seller_id , dense_rank() over(ORDER BY total_amt DESC) as ranking
    from t1)

SELECT seller_id
from t2
WHERE ranking = 1
;

-- Q 66

INSERT INTO Sales VALUES (1,1,1,'2019-01-21',2,2000),(1,2,2,'2019-02-17',1,800),(2,1,3,'2019-06-02',1,800),(3,3,3,'2019-05-13',2,2800);

--  Write an SQL query that reports the buyers who have bought S8 but not iPhone. Note that S8 and
-- iPhone are products present in the Product table

with t1 as(
    SELECT case when p.prod_name ='S8' then buyer_id else -1 end as s8_buyer,
           case when p.prod_name ='iPhone' then buyer_id else -1 end as iPhone_buyer
    from Sales s
    JOIN Product p
    ON p.prod_id = s.prod_id)

SELECT buyer_id 
from Sales
WHERE buyer_id IN (SELECT s8_buyer from t1) 
AND buyer_id NOT IN (SELECT iPhone_buyer from t1)
;

-- Q 67
CREATE Table customer
(
    cust_id INT,
    name VARCHAR(50),
    visited_on DATE,
    amt INT,
    constraint pk PRIMARY KEY (cust_id , visited_on)
);

INSERT INTO customer VALUES (1,'Jhon','2019-01-01',100),(2,'Daniel','2019-01-02',110),(3,'Jade','2019-01-03',120),(4,'Khaled','2019-01-04',130),(5,'Winston','2019-01-05',110),(6,'Elvis','2019-01-06',140),(7,'Anna','2019-01-07',150),(8,'Maria','2019-01-08',80),(9,'Jaze','2019-01-09',110),(1,'Jhon','2019-01-10',130),(3,'Jade','2019-01-10',150);

SELECT visited_on , SUM(amt) over(ORDER BY  range between 6 preceding and current row)
FROM customer;

-- Q 68

CREATE Table scores
(
    player_name VARCHAR(50),
    gender VARCHAR(2),
    day DATE,
    score_points INT,
    constraint pk PRIMARY KEY (gender ,day)
);

INSERT INTO scores VALUES ('Aron','F','2020-01-01',17),('Alice','F','2020-01-07',23),('Bajrang','M','2020-01-07',7),('Khali','M','2019-12-25',11),('Slaman','M','2019-12-30',13),('Joe','M','2019-12-31',3),('Jose','M','2019-12-18',2),('Priya','F','2019-12-31',23),('Priyanka','F','2019-12-30',17);

-- Write an SQL query to find the total score for each gender on each day.
-- Return the result table ordered by gender and day in ascending order.
SELECT gender , day , 
       SUM(score_points) over(partition by gender ORDER BY day ) as total 
from scores;

-- Q 69

-- Q 70

CREATE Table students
(
    stu_id int PRIMARY KEY,
    stu_name VARCHAR(50) 

);

CREATE Table subjects
(
    sub_name VARCHAR(25) PRIMARY KEY
);

CREATE Table examinations
(
    stu_id INT,
    sub_name VARCHAR(50)
);

INSERT INTO students VALUES  (1,'Alice'),(2,'Bob'),(13,'John'),(6,'Alex');

INSERT INTO subjects VALUES ('Math'),('Physics'),('Programming');

INSERT INTO examinations VALUES (1,'Math'),(1,'Physics'),(1,'Programming'),(2,'Programming'),(1,'Physics'),(1,'Math'),(13,'Math'),(13,'Programming'),(13,'Physics'),(2,'Math'),(1,'Math');

-- Q 70) Write an SQL query to find the number of times each student attended each exam.
-- Return the result table ordered by student_id and subject_name

SELECT s.stu_id , s.stu_name , e.sub_name 
from students s
LEFT JOIN examinations e
ON e.stu_id = s.stu_id
 JOIN subjects sub
ON sub.sub_name = e.sub_name
-- GROUP BY s.stu_id , s.stu_name , e.sub_name
;

SELECT s.stu_id , s.stu_name , e.sub_name 
from students s
LEFT JOIN examinations e
ON e.stu_id = s.stu_id;
RIGHT JOIN subjects sub
ON ;

with t1 as (
    SELECT * from students,subjects
    ),

t2 as(
    SELECT stu_id , sub_name , count(*) as attended_exams
    from examinations
    GROUP BY stu_id , sub_name
    )

SELECT t1.stu_id ,s.stu_name, t1.sub_name , 
       coalesce(t2.attended_exams , 0)
from t1 
LEFT JOIN t2
ON t1.stu_id = t2.stu_id 
AND 
t1.sub_name =t2.sub_name 
JOIN students s
ON t1.stu_id = s.stu_id
ORDER BY t1.stu_id , t1.sub_name
;

-- Q 71
CREATE TABLE employees
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    mgr_id INT
);

INSERT INTO employees VALUES (1,'Boss',1),(3,'Alice',3),(2,'Bob',1),(4,'Daniel',2),(7,'Luis',4),(8,'Jhon',3),(9,'Angela',8),(77,'Robert',1); 

-- Write an SQL query to find employee_id of all employees that directly or indirectly report their work to
-- the head of the company
with recursive reporting (emp_id )
as (
    SELECT emp_id 
    from employees 
    WHERE mgr_id=1
    UNION
    SELECT e.emp_id 
    from reporting r
    JOIN employees e
    ON e.mgr_id = r.emp_id
    
)

SELECT * from reporting 
WHERE emp_id !=1 ;

-- Q 72
CREATE TABLE transactions
(
    id INT PRIMARY KEY,
    country VARCHAR(50),
    state ENUM('approved' ,'declined'),
    amt INT,
    trans_date DATE
);

INSERT INTO transactions VALUES (121,'US','approved',1000,'2018-12-18'),(122,'US','declined',2000,'2018-12-19'),(123,'US','approved',2000,'2019-01-01'),(124,'DE','approved',2000,'2019-01-07');

-- Write an SQL query to find for each month and country, the number of transactions and their total
-- amount, the number of approved transactions and their total amount.
-- Return the result table in any order.

SELECT country,LEFT(trans_date,7),COUNT(*) as trans_count , 
SUM(case when state=1 then 1 end) as approved_count,
SUM(amt) as trans_total_amount,
SUM(case when state=1 then amt else 0 end) as approved_total_amt
from transactions
GROUP BY country , 
         LEFT(trans_date,7);


-- Q 73
CREATE Table actions
(
    user_id INT,
    post_id INT,
    action_date DATE,
    action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'),
    extra VARCHAR(20)
);

CREATE Table removals
(
    post_id INT PRIMARY KEY,
    remove_date DATE
);

INSERT INTO actions VALUES 
(1,1,'2019-07-01','view',null),(1,1,'2019-07-01','like',null),(1,1,'2019-07-01','share',null),(2,2,'2019-07-04','view',null),(2,2,'2019-07-04','report','spam'),(3,4,'2019-07-04','view',null),(3,4,'2019-07-04','report','spam'),(4,3,'2019-07-02','view',null),(4,3,'2019-07-02','report','spam'),(5,2,'2019-07-03','view',null),(5,2,'2019-07-03','report','racism'),(5,5,'2019-07-03','view',null),(5,5,'2019-07-03','report','racism');

INSERT INTO removals VALUES (2,'2019-07-20'),(3,'2019-07-18');

-- Q 73) Write an SQL query to find the average daily percentage of posts that got removed after being
-- reported as spam, rounded to 2 decimal places.



with reported_post as(
    SELECT DISTINCT post_id , action_date   
    from actions
    WHERE  action=5 AND extra='spam'
    ),

daily_report_remove as( 
    SELECT action_date , 
    (
        SUM(CASE when post_id in (SELECT post_id from removals) then 1 else 0 end) *100 / 
        Count(*)
        )
     as percent_removed_post 
from reported_post
GROUP BY action_date)

SELECT round(avg(percent_removed_post),2)
from daily_report_remove
;


-- Q 74 Question repeated (Already solved in set 1)

-- Q 75 Question same as 74

-- Q 76

CREATE Table salaries
(
    cmp_id INT,
    emp_id INT ,
    emp_name VARCHAR(50) ,
    salary INT ,
    constraint pk PRIMARY KEY (cmp_id , emp_id)
);

INSERT INTO salaries VALUES (1,1,'Tony',2000),(1,2,'Pronub',21300),(1,3,'Tyrrox',10800),(2,1,'Pam',300),(2,7,'Bassem',450),(2,9,'Hermione',700),(3,7,'Bocaben',100),(3,2,'Ognjen',2200),(3,13,'Nyan Cat',3300),(3,15,'Morning Cat',7777);


-- Write an SQL query to find the salaries of the employees after applying taxes. Round the salary to the
-- nearest integer.
-- The tax rate is calculated for each company based on the following criteria:
-- ??? 0% If the max salary of any employee in the company is less than $1000.
-- ??? 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
-- ??? 49% If the max salary of any employee in the company is greater than $10000.

with t1 as (
    SELECT cmp_id , emp_id ,emp_name,salary,
    MAX(salary) over(partition by cmp_id) as max_salary 
    from salaries
)

SELECT cmp_id , emp_id ,emp_name ,
        case 
        when max_salary >10000 then round(salary - (salary * 0.49),0)
        when max_salary BETWEEN 1000 AND 10000 then round(salary - (salary * 0.24) ,0) 
        else round(salary,0)
        end as salary_after_tax
FROM t1
;














