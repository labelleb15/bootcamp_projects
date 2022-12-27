-- Restaurant Owners
-- 5 tables
-- 1x fact , 4x dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery / with

.mode markdown
.header on
  
--Fact Table--
Create table FACT_ORDERS (
  order_id int primary key,
  order_date date,
  menu_id int,
  customers_id int,
  payment_id int,
  staff_id int,
  FOREIGN KEY(menu_id) REFERENCES menu(menu_id),
  FOREIGN KEY(customers_id) REFERENCES customers(customers_id),
  FOREIGN KEY(payment_id) REFERENCES payment(payment_id),
  FOREIGN KEY(staff_id) REFERENCES staff(staff_id));

INSERT INTO FACT_ORDERS VALUES 
  (1,  '2022-09-12', 3, 1, 4, 4),
  (2,  '2022-08-28', 1, 2, 1, 4),
  (3,  '2022-08-28', 1, 3, 1, 3),
  (4,  '2022-08-28', 5, 4, 2, 3),
  (5,  '2022-08-29', 2, 5, 3, 4);

--Dimension 1--
CREATE TABLE MENU
  (menu_id int primary key,
  menu_name varchar(200),
  menu_price real);

--INSERT DATA TO DIMENSION 1--
INSERT INTO MENU VALUES
  (1,'strawberry ice cream',5),
  (2,'chocolate icecream',3.5),
  (3,'vanila icecream',3.5),
  (4,'lemon icecream',4),
  (5,'mint icecream',4.5);

--Dimension 2--
CREATE TABLE CUSTOMERS
  (customers_id int primary key,
   customers_gender varchar(200),
   customers_firstname varchar(200),
   customers_lastname varchar(200),
   customers_age int );

--INSERT DATA TO DIMENSION 2--
INSERT INTO CUSTOMERS VALUES 
  (1,'M','Dawid','Krajewski','25'),
  (2,'F','Helen','Robert','32'),
  (3,'F','Wendy','Reynolds','26'),
  (4,'M','Oliver','Charmichael','30'),
  (5,'F','Penny','Diaz', '33');

--Dimension 3 --
CREATE TABLE PAYMENT 
 (payment_id int primary key,
  payment_method vachar(200));

--INSERT DATA TO DIMENSION 3--
INSERT INTO PAYMENT VALUES
  (1,'Cash'),
  (2,'Credit card'),
  (3,'Blik'),
  (4,'Apple pay');

--Dimension 4 --
CREATE TABLE STAFFS 
  (staff_id int primary key,
   staff_gender varchar(200),
   staff_firstname varchar(200),
   staff_lastname varchar(200),
   staff_position varchar(200),
   staff_contract int );

--INSERT DATA TO DIMENSION 4
INSERT INTO STAFFS VALUES
  (1,'F','Lena','Smith','Manager','1'),
  (2,'M','Tom','Taylor','Cashier','1'),
  (3,'M','Paul','Lee','Ice Cream Scooper','2'),
  (4,'F','Lucy','White','Ice Cream Scooper','2');

--QUERY 1--
SELECT
  order_date,
  STRFTIME ('%Y', order_date) as year,
  STRFTIME ('%m', order_date) as month,
  STRFTIME ('%d', order_date) as day,
  STRFTIME ('%Y-%m',order_date) as monthid
from fact_orders
WHERE month = '09';

--QUERY 2--
 SELECT
 customers.customers_firstname,
 menu.menu_name,
 payment.payment_method
from fact_orders
  join customers
  on fact_orders.customers_id = customers.customers_id
  join menu
  on fact_orders.menu_id = menu.menu_id
  JOIN payment 
  on fact_orders.payment_id = payment.payment_id;

--QUERY 3--
Select staff_contract,
	CASE
    WHEN staff_contract is '1' THEN 'FULL-TIME'
    ELSE 'PART TIME'
END
from STAFFS;

--SUB query--

Select MAX(menu_price),
       MIN(menu_price)
       from Menu;

Select customers_firstname,
       MIN(customers_age),
       customers_gender
from customers;


