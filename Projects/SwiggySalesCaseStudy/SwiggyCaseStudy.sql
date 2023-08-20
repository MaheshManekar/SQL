-- Q1) Find the customer who have never ordered

-- select name from users where user_id NOT IN (select user_id from orders);

-- Q2) Average price per dish (price/dish)

-- select f.f_name, avg(price) as "Avg Price"
-- from menu m
-- join food f
-- on m.f_id = f.f_id 
-- group by f.f_name;

-- Q3) Find top restaurant in terms of number of orders for a given month

-- select r.r_name, count(*) AS 'month'
-- from orders o
-- join restaurants r
-- on o.r_id = r.r_id
-- where monthname(date) LIKE 'May'
-- group by r.r_name
-- order by count(*) Desc limit 1;

-- Q4) Restaurants with monthly sales > x

-- select r.r_name, sum(amount) as 'revenue'
-- from orders o
-- join restaurants r
-- on o.r_id = r.r_id
-- where monthname(date) LIKE 'June' 
-- group by r.r_name
-- having revenue > 500;

-- Q5) show all orders with order details for a particular customer in particular date range

-- select o.order_id, r.r_name, f.f_name
-- from orders o
-- join restaurants r
-- on o.r_id = r.r_id
-- join order_details od
-- on o.order_id = od.order_id
-- join food f
-- on f.f_id = od.f_id
-- where user_id = (select user_id from users where name = 'Ankit') 
-- and date between '2022-06-10' and '2022-07-10';

-- Q6) Find restaurants with max repeated customers

-- SELECT 
--     r.r_name, COUNT(*) AS 'loyal_customer'
-- FROM
--     (SELECT 
--         r_id, user_id, COUNT(*) AS 'Visits'
--     FROM
--         orders
--     GROUP BY r_id , user_id
--     HAVING Visits > 1
--     ORDER BY r_id) t
--         JOIN
--     restaurants r ON r.r_id = t.r_id
-- GROUP BY r.r_name
-- ORDER BY loyal_customer DESC
-- LIMIT 1;


-- Q7) Month over month revenue growth of swiggy

-- select month, ((revenue-prev)/prev)*100 from
-- (with sales as 
-- (select monthname(date) 'month' , sum(amount) 'revenue' 
-- from orders 
-- group by monthname(date))
-- select month, revenue, lag(revenue, 1) over(order by revenue) as prev from sales) t;

-- Q8) Favourite food of customer (customer Name)

with temp as (select o.user_id, od.f_id, count(*) as 'Frequency' from orders o join order_details od on o.order_id = od.order_id
group by o.user_id, od.f_id) select u.name, f.f_name, t1.Frequency from temp t1 join users u on u.user_id = t1.user_id join food f on f.f_id = t1.f_id where
t1.Frequency = (select MAX(Frequency) from temp t2 where t2.user_id = t1.user_id);