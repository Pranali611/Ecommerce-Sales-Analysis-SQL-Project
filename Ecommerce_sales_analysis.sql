select *from ecommerce_sales
select *from ecommerce_product
select *from ecommerce_persons
select *from ecommerce_customer




select 
    time AS month
from ecommerce_sales
GROUP BY  time


#Analyze the total revenue generated per month.#
SELECT 
    TO_CHAR(Time, 'YYYY-MM') AS month,
    SUM(Total_sales) AS total_revenue
FROM ecommerce_sales
GROUP BY TO_CHAR(Time, 'YYYY-MM')
ORDER BY month;

#Identify the top 2 best-selling products.#

SELECT * FROM (
    SELECT product_id, product_name, SUM(SELLING_PRICE) AS total_sales
    FROM Ecommerce_product
    GROUP BY product_id, product_name
    ORDER BY total_sales DESC                     
) WHERE ROWNUM = 2;

#Find the total sales made by each salesperson.#   

select 
    p.SALESPERSON_NAME, 
    p.salesperson_id,
    SUM(e.total_sales) AS total_sales
from ecommerce_persons p
join ecommerce_sales e ON p.salesperson_id = e.salesperson_id
GROUP BY p.salesperson_id, p.SALESPERSON_NAME
ORDER BY total_sales Desc;


#Calculate the average order value per customer.#

SELECT customer_id, 
       AVG(total_orders) AS avg_order_value
FROM Ecommerce_customer
GROUP BY customer_id
ORDER BY avg_order_value DESC; 

#Identify which region has the highest revenue.#
Select* From 
(Select REGION ,salesperson_id,SUM(Total_Sales) As Region_Revenue
             From Ecommerce_Sales
             Group by salesperson_id,REGION
               order by region_revenue Desc
)WHERE ROWNUM = 2;

SELECT REGION, salesperson_id, Region_Revenue
FROM (
    SELECT REGION, salesperson_id, SUM(Total_Sales) AS Region_Revenue,
           ROW_NUMBER() OVER (ORDER BY SUM(Total_Sales) DESC) AS rn
    FROM Ecommerce_Sales
    GROUP BY REGION, salesperson_id
)
WHERE rn = 2;


Find customers who have made more than 3 purchases

SELECT customer_id, COUNT(Total_orders) AS total_purchases
FROM Ecommerce_customer
GROUP BY customer_id
HAVING COUNT(*) > 2;

SELECT customer_id,Total_orders
FROM Ecommerce_customer                                         
Where Total_orders <= 3; 

#Determine the most profitable product category.#
SELECT *FROM 
(   SELECT CATEGORY, SUM(SELLING_PRICE) AS total_profit
    FROM Ecommerce_product
    GROUP BY CATEGORY
    ORDER BY total_profit DESC
)
WHERE ROWNUM = 1;

