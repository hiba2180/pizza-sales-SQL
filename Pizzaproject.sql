create database pizza;
use pizza;
show tables;
select * from order_details; 
select * from orders;
select * from pizzas;
select * from pizza_types;


-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2 ) AS total_revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id;
    
   -- Identify the highest-priced pizza.
   
  SELECT 
    p.price, pt.name
FROM
    pizzas AS p
        INNER JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(od.order_details_id) AS total_orders
FROM
    pizzas AS p
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY total_orders DESC;

-- List the top 5 most ordered pizza types along with their quantities

SELECT 
    pt.name, SUM(od.quantity) AS total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered

SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day

select hour(time) as hour , count(order_id) as number_of_order
 from orders
 group by hour;
 
 -- find the category-wise distribution of pizzas.
select category , count(name) as total
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(numberoforders), 0) AS average_pizza_ordered
FROM
    (SELECT 
        o.date, SUM(od.quantity) AS numberoforders
    FROM
        orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY o.date) AS order_quantity;
    
    
    -- Determine the top 3 most ordered pizza types based on revenue
    
    select pt.name, ROUND(sum(p.price*od.quantity) , 0)  as revenue 
    from pizzas as p 
    join pizza_types as pt 
    on p.pizza_type_id = pt.pizza_type_id
    join order_details as od 
    on p.pizza_id = od.pizza_id 
    group by pt.name 
    order by revenue desc limit 3 ;
    
