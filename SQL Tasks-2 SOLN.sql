-- 1. JOINS 
-- Task 1: 
-- Retrieve the customer_name, city, and order_date for each customer who 
-- placed an order in 2023 by joining the customers and orders tables. 

SELECT customer_name, city, order_date 
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
WHERE EXTRACT(year From order_date)=2023;

-- Task 2: 
-- Get a list of all products (with product_name, category, and total_price) 
-- ordered by customers living in Mumbai, by joining the customers, orders, 
-- order_items, and products tables.

SELECT product_name, category, SUM(total_price) as total_price
FROM products, customers, order_items, orders
WHERE customers.customer_id=orders.customer_id
AND products.product_id=order_items.product_id
AND customers.city='Mumbai'
GROUP BY product_name, category

-- Task 3: 
-- Find all orders where customers paid using 'Credit Card' and display the 
-- customer_name, order_date, and total_price by joining the customers, 
-- orders, and order_items tables. 
SELECT customer_name, order_date, total_price, payment_mode
FROM customers c, orders o, products p, order_items oi
WHERE c.customer_id=o.customer_id
AND p.product_id=oi.product_id
AND o.payment_mode='Credit Card';

-- Task 4: 
-- Display the product_name, category, and the total_price for all products 
-- ordered in the first half of 2023 (January - June) by joining the orders, 
-- order_items, and products tables.

SELECT product_name, category, total_price, order_date
FROM products p, orders o, order_items oi
WHERE p.product_id=oi.product_id
AND o.order_id=oi.order_id
AND (EXTRACT(YEAR FROM o.order_date)=2023)
AND order_date<'2023-07-01'::date;

-- Task 5: 
-- Show the total number of products ordered by each customer, displaying 
-- customer_name and total products ordered, using joins between 
-- customers, orders, and order_items.

SELECT customer_name, sum(quantity) as total_products_ordered
FROM customers c, orders o, order_items oi
WHERE c.customer_id=o.customer_id
AND o.order_id=oi.order_id
GROUP BY customer_name, o.order_id ;

-- 2. DISTINCT 
-- Task 1: 
-- Get a distinct list of cities where customers are located.
SELECT DISTINCT city FROM customers;

-- Task 2: 
-- Retrieve distinct supplier_name from the products table.
SELECT DISTINCT supplier_name FROM products;

-- Task 3: 
-- Find distinct payment methods used in the orders table. 
SELECT DISTINCT payment_mode FROM orders;

-- Task 4: 
-- List all distinct product categories that have been ordered.
SELECT DISTINCT category FROM products;

-- Task 5: 
-- Find distinct cities from which suppliers supply products by querying the 
-- products table.
SELECT DISTINCT supplier_city FROM products;


-- 3. ORDER BY 
-- Task 1: 
-- List all customers sorted by customer_name in ascending order. 
SELECT customer_name FROM customers
ORDER BY customer_name;

-- Task 2: 
-- Display all orders sorted by total_price in descending order. 
SELECT order_id, total_price
FROM order_items 
ORDER BY total_price DESC;

-- Task 3: 
-- Retrieve a list of products sorted by price in ascending order and then by 
-- category in descending order. 
SELECT product_name, category, price
FROM products
ORDER BY price ASC, category DESC ;

-- Task 4: 
-- Sort all orders by order_date in descending order and display the order_id, 
-- customer_id, and order_date. 
SELECT order_id, c.customer_id, order_date
FROM customers c, orders o
WHERE c.customer_id=o.customer_id
ORDER BY order_date DESC;

-- Task 5: 
-- Get the list of cities where orders were placed, sorted in alphabetical order, 
-- and display the total number of orders placed in each city.
SELECT c.city, COUNT(o.order_id)
FROM customers c, orders o
WHERE c.customer_id=o.customer_id
GROUP BY c.city
ORDER BY c.city;

-- 4. LIMIT & OFFSET 
-- Task 1: 
-- Retrieve the first 10 rows from the customers table ordered by 
-- customer_name.
SELECT * FROM customers
ORDER BY customer_name LIMIT 10;

-- Task 2: 
-- Display the top 5 most expensive products (sorted by price in descending 
-- order). 
SELECT product_name, price FROM products
ORDER BY price DESC LIMIT 5;

-- Task 3: 
-- Get the orders for the 11th to 20th customers (using OFFSET and LIMIT), 
-- sorted by customer_id. 
SELECT c.customer_id, c.customer_name,o.order_id 
FROM customers c, orders o
WHERE c.customer_id=o.customer_id
ORDER BY c.customer_id 
LIMIT 10 OFFSET 10;

-- Task 4: 
-- List the first 5 orders placed in 2023, displaying order_id, order_date, and 
-- customer_id. 
SELECT o.order_id, o.order_date, c.customer_id
FROM customers c, orders o
WHERE c.customer_id=o.customer_id
AND EXTRACT(YEAR FROM o.order_date)=2023
ORDER BY order_date LIMIT 5;

-- Task 5: 
-- Fetch the next 10 distinct cities where orders were placed, using LIMIT and 
-- OFFSET.
SELECT o.order_id, o.order_date, c.customer_id
FROM customers c, orders o
WHERE c.customer_id=o.customer_id
AND EXTRACT(YEAR FROM o.order_date)=2023
ORDER BY order_date LIMIT 10 OFFSET 5;

-- 5. AGGREGATE FUNCTIONS 
-- Task 1: 
-- Calculate the total number of orders placed by all customers.
SELECT c.customer_name,SUM(oi.quantity) as total_orders
FROM customers c, orders o, order_items oi
WHERE c.customer_id=o.customer_id
AND o.order_id=oi.order_id
GROUP BY c.customer_name

-- Task 2: 
-- Find the total revenue generated from orders paid via 'UPI' from the orders 
-- table.
SELECT payment_mode, SUM(order_amount) as total_revenue
FROM orders
WHERE payment_mode='UPI'
GROUP BY payment_mode;

-- Task 3: 
-- Get the average price of all products in the products table. 
SELECT  ROUND(AVG(price)) as avg_price
FROM products

-- Task 4: 
-- Find the maximum and minimum total price of orders placed in 2023. 
SELECT MAX(order_amount)
FROM orders
WHERE EXTRACT(YEAR FROM order_date)=2023

SELECT MIN(order_amount)
FROM orders
WHERE EXTRACT(YEAR FROM order_date)=2023

-- Task 5: 
-- Calculate the total quantity of products ordered for each product_id using 
-- the order_items table. 
SELECT products.product_name, SUM(order_items.quantity) as total_quantity
FROM products, order_items
WHERE products.product_id=order_items.product_id
GROUP BY products.product_name;

-- 6. SET OPERATIONS 
-- Task 1: 
-- Get the list of customers who have placed orders in both 2022 and 2023 
-- (use INTERSECT). 
SELECT  c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2022

INTERSECT

SELECT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2023;


-- Task 2: 
-- Find the products that were ordered in 2022 but not in 2023 (use EXCEPT). 
SELECT p.product_name 
FROM products p, orders o, order_items oi
WHERE p.product_id=oi.product_id AND o.order_id=oi.order_id
AND EXTRACT(YEAR FROM o.order_date) = 2022
EXCEPT
SELECT p.product_name 
FROM products p, orders o, order_items oi
WHERE p.product_id=oi.product_id AND o.order_id=oi.order_id
AND EXTRACT(YEAR FROM o.order_date) = 2023;
-- Task 3: 
-- Display the list of supplier_city from the products table that do not match 
-- any customer_city in the customers table (use EXCEPT).
SELECT DISTINCT supplier_city FROM products
EXCEPT
SELECT DISTINCT city FROM customers;
-- Task 4: 
-- Show a combined list of supplier_city from products and city from 
-- customers (use UNION). 
SELECT DISTINCT supplier_city FROM products
union
SELECT DISTINCT city FROM customers;
-- Task 5: 
-- Find the list of product_name from the products table that were ordered in 
-- 2023 (use INTERSECT with the orders and order_items tables). 
SELECT DISTINCT p.product_name
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2023

INTERSECT

SELECT DISTINCT p.product_name
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id;















