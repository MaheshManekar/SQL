-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;


-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

-- Data cleaning and Feature Engineering
SELECT
	*
FROM sales;


-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- ----------------------------------------------------------------------------------------------------

-- Add day_name column
select date, dayname(date) from sales;

Alter table sales add column day_name varchar(10);

update sales
set day_name = dayname(date);

-- ----------------------------------------------------------------------------------------------------

-- Add month_name column 

select date, monthname(date) from sales;

Alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

-- Generic Questions
-- How many unique cities does the data have?

SELECT DISTINCT
    (city)
FROM
    sales;

-- In which city is each branch?

SELECT DISTINCT
    (city), branch
FROM
    sales;
    

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------Product Related Questions ----------------------------------------

-- How many unique product lines does the data have?
select distinct(product_line) from sales;

-- What is the most common payment method?
select distinct(payment),count(payment) as total_count from sales group by payment order by total_count DESC;

-- What is the most selling product line?
select distinct(product_line),count(product_line) as total_count from sales group by product_line order by total_count DESC;

-- What is the total revenue by month?
SELECT DISTINCT
    (month_name), SUM(total) AS total_revenue
FROM
    sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS (Cost of Goods Sold)?
SELECT DISTINCT
    (month_name), SUM(cogs) AS COGS
FROM
    sales
GROUP BY month_name
ORDER BY COGS DESC;

-- What product line had the largest revenue?
SELECT DISTINCT
    (product_line), sum(total) AS Revenue
FROM
    sales
GROUP BY product_line
ORDER BY Revenue DESC;

-- Which city has the largest revenue?
SELECT DISTINCT
    (city), sum(total) AS Revenue
FROM
    sales
GROUP BY city
ORDER BY Revenue DESC;

-- Which product line had the largest VAT?
SELECT DISTINCT
    (product_line), avg(tax_pct) AS VAT
FROM
    sales
GROUP BY product_line
ORDER BY VAT DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT
	product_line,
	(CASE
		WHEN total > avg(total) then "Good"
        WHEN total < avg(total) then "Bad"
		ELSE ""
    END) AS Status1
FROM sales;

-- Which branch sold more products than average product sold?
SELECT branch, sum(quantity) as QTY from sales group by branch having sum(quantity) > (select avg(quantity) from sales);

-- What is the most common product line by gender?
select gender, product_line, count(gender) as total_count from sales group by gender, product_line order by total_count DESC;

-- What is the average rating of each product line?
select product_line, round(avg(rating), 2) As rating from sales group by product_line order by rating DESC;

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
-- ---------------------------------- Sales Related Questions -----------------------------------------

-- Number of sales made in each time of the day per weekday?
select time_of_day, count(*) as total_sales from sales group by time_of_day;

-- Which of the customer types brings the most revenue?
select customer_type, round(sum(total),2) as TotalRevenue from sales group by customer_type order by TotalRevenue DESC;

-- Which city has the largest tax percentage/ VAT(Value Added Tax)?
select city, avg(tax_pct) as VAT from sales group by city order by vat desc;

-- Which Customer type pays the most in VAT?
select customer_type, round(avg(tax_pct),2) as VAT from sales group by customer_type order by VAT DESC;

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
-- ---------------------------------- Customer Related Questions --------------------------------------

-- How many unique customer types does the data have?
select distinct(customer_type) from sales;

-- How many unique payment methods does the data have?
select distinct(payment) from sales;

-- What is the most common customer type?
select customer_type, count(customer_type) as count from sales group by customer_type order by count;

-- What is the gender of most of the customers?
select gender, count(*) as gender_count from sales group by gender order by gender_count DESC;

-- What is the gender distribution per branch?
select gender, count(*) as gender_count from sales where branch = "C" group by gender order by gender_count DESC;

-- Which time of the day do customers give the most ratings?
select time_of_day, avg(rating) as avg_rating from sales group by time_of_day order by avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
select time_of_day, avg(rating) as avg_rating from sales where branch = "C" group by time_of_day order by avg_rating DESC;

-- Which day of the week has the best average rating?
select day_name, avg(rating) as avg_rating from sales group by day_name order by avg_rating DESC;

-- Which day of the week has the best average rating per branch?
select day_name, avg(rating) as avg_rating from sales where branch = "C" group by day_name order by avg_rating DESC;

