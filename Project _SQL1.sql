-- DATA Cleaning

SELECT * FROM retail_sales
WHERE

 transactions_id IS NULL
 OR
 sale_date  IS NULL
 OR
 sale_time  IS NULL
 OR
 customer_id IS NULL
 OR
 gender IS NULL
 OR
 age  IS NULL
 OR
 category  IS NULL
 OR
 quantiy  IS NULL
 OR
 price_per_unit  IS NULL
 OR
 cogs  IS NULL
 OR
 total_sale IS NULL;




DELETE FROM retail_sales
WHERE
 transactions_id IS NULL
 OR
 sale_date  IS NULL
 OR
 sale_time  IS NULL
 OR
 customer_id IS NULL
 OR
 gender IS NULL
 OR
 age  IS NULL
 OR
 category  IS NULL
 OR
 quantiy  IS NULL
 OR
 price_per_unit  IS NULL
 OR
 cogs  IS NULL
 OR
 total_sale IS NULL;


-- DATA Exploration
-- How many sales we have ?

 SELECT COUNT(*) as Total_Sale FROM retail_sales

 SELECT COUNT( DISTINCT total_sale) as sale FROM retail_sales

-- How many customers we have?
 SELECT DISTINCT customer_id FROM retail_sales

 
 SELECT DISTINCT sale_date FROM retail_sales

 -- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

 SELECT * FROM retail_sales
 WHERE sale_date = '2022-11-05';

 -- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:


 SELECT 
*

FROM retail_sales
WHERE 
category = 'Clothing'
 AND
TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
AND
quantiy>=3;

-- Write a SQL query to calculate the total sales (total_sale) for each category.:


 SELECT category,
 SUM(total_sale) AS net_sale,
 count(*) as total_orders
 FROM retail_sales
 GROUP BY 1;



-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT 
AVG(age) AS age_of_customers
FROM retail_sales
WHERE category = 'Beauty'

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM retail_sales
WHERE total_sale > 1000;



-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 

category,
    gender,
COUNT(*) AS total_trasnactions
FROM retail_sales
GROUP BY category,
    gender

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


 SELECT * FROM retail_sales

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

 SELECT category,
 COUNT(DISTINCT customer_id) 
 FROM retail_sales
 GROUP BY category

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
