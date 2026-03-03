SELECT * 
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` LIMIT 10

1. --- Record Count: Determine the total number of records in the dataset.

SELECT 
COUNT(*)
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales`

 2. --- Customer Count: Find out how many unique customers are in the dataset.

SELECT 
COUNT(DISTINCT customer_id) 
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 

3. ---Category Count: Identify all unique product categories in the dataset.

SELECT
DISTINCT category
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 

4. ---Null Value Check: Check for any null values in the dataset and delete records with missing data.

SELECT *
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR customer_ID IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

DELETE from `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR customer_ID IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

5. ----Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * 
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 
WHERE sale_date = '2022-11-05'

6. ---Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales`
WHERE category = 'Clothing'
AND FORMAT_DATE('%Y_m%',sale_date) = '2022-11'
AND quantiy >= 4

7. --- Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT
DISTINCT category AS shopping_cat,
SUM(total_sale) AS total_revenue
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales`
GROUP BY shopping_cat


8.--- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
ROUND(AVG(age),2) AS avg_age_purchase,
category 
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales`
WHERE category = 'Beauty'

GROUP BY category

9.---Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * 
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 
WHERE total_sale >= 1000

10. --- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT
SUM(transactions_id) AS total_transactions,
gender
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 

GROUP BY gender

11. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

WITH monthly_sales AS (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_total_sales
  FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales`
  GROUP BY year, month
)

SELECT
  year,
  month,
  avg_total_sales,
  RANK() OVER (
    PARTITION BY year
    ORDER BY avg_total_sales DESC
  ) AS rank
FROM monthly_sales
QUALIFY rank = 1
ORDER BY year, month;

12.--- Write a SQL query to find the top 5 customers based on the highest total sales:


SELECT
customer_id,
SUM(total_sale) AS total_spent
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 

GROUP BY customer_id
ORDER BY total_spent DESC LIMIT 5

13. ---Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
category,
COUNT(DISTINCT customer_id) AS unique_cust
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 

GROUP BY category

14. --- **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:


WITH hourly_sale
AS
(
SELECT *,
  CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM `project-e14ed125-55fc-4bc9-a61.Retail_DB.retail_sales` 
)

SELECT
shift,
COUNT(*) AS total_orders 
FROM hourly_sale

GROUP BY shift





