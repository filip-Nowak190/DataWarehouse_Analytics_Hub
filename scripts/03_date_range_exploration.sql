-- Find the date of the first and last order
-- How many years of sales are avaiable 
Select 
MIN(Order_Date) as first_order_date,
MAX(Order_Date) as last_order_date,
DATEDIFF(year, MIN(Order_Date),MAX(Order_Date)) as orders_range_years
FROM gold.fact_sales 

-- Find the youngest and oldest customer
SELECT
MIN(BirthDate) AS oldest_birthdate,
MAX(BirthDate) AS youngest_birthdate,
DATEDIFF(year,MIN(BirthDate),GETDATE()) as oldest_customer,
DATEDIFF(year,MAX(BirthDate),GETDATE()) as youngest_customer
FROM gold.dim_customers
