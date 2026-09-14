/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales
to both the average sales performance of the product and the previous year's sales */


WITH yearly_products_sales AS ( 
SELECT 
YEAR(f.order_date) as order_YEAR,
p.product_name,
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL 
GROUP BY p.product_name, YEAR(f.order_date)
) 

SELECT 
order_YEAR,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name ) AS avg_sales,
current_sales -  AVG(current_sales) OVER (PARTITION BY product_name )  AS diff_avg,
CASE WHEN current_sales -  AVG(current_sales) OVER (PARTITION BY product_name ) > 0 THEN 'Above Avg'
	 WHEN current_sales -  AVG(current_sales) OVER (PARTITION BY product_name ) < 0 THEN 'Below Avg'
	 ELSE 'Avg'
END avg_change,
-- Year-over-year Analysis
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_YEAR) py_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_YEAR) AS diff_py,
CASE WHEN current_sales -  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_YEAR)  > 0 THEN 'Increase'
	 WHEN current_sales -  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_YEAR) < 0 THEN 'Decrease'
	 ELSE 'No Change'
END py_change
FROM yearly_products_sales
ORDER BY product_name, order_YEAR
