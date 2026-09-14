-- Find the Total Sales
Select sum(Sales_Amount) as Total_SALES  from gold.fact_sales 
-- Find how many items are sold
Select SUM(Quantity) as Total_sales_quantity from gold.fact_sales 
-- Find the average selling price
Select AVG(Price) as Avg_Price  From gold.fact_sales
-- Find the Total number of Orders
Select COUNT(Order_Number) AS total_orders from gold.fact_sales
Select COUNT(DISTINCT(Order_Number)) AS total_orders from gold.fact_sales
-- Find the total number of products
Select COUNT(Product_Name) AS total_products from gold.dim_products
-- Find the total number of customers
Select COUNT(customer_key) AS Total_Customers FROM gold.dim_customers
-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;


Select 'Total Sales' as measure_name, sum(Sales_Amount) as measure_value  from gold.fact_sales 
UNION ALL 
Select 'Total Quantity' as measure_name, sum(Sales_Amount) as measure_value  from gold.fact_sales 
UNION ALL 
Select 'AVG Price' as measure_name, AVG(Price) as measure_value  from gold.fact_sales 
UNION ALL
Select 'Total Orders' as measure_name, COUNT(DISTINCT(Order_Number)) as measure_value  from gold.fact_sales 
UNION ALL
Select 'Total Products' as measure_name, COUNT(Product_Name) as measure_value  from gold.dim_products
UNION ALL
Select 'Total Customers' as measure_name, COUNT(DISTINCT customer_key)as measure_value  from gold.dim_customers
