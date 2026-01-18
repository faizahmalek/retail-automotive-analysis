-- =====================================================
-- Retail Sales Performance Analysis
-- File: advanced_analysis.sql
-- Description: Advanced SQL queries for customer, product,
--              regional, and trend-based analysis
-- Dataset: sales_data_cleaned.csv
-- Table: orders
-- =====================================================


-- =====================================================
-- 1. Top 5 customers by total revenue
-- =====================================================
SELECT
    CUSTOMERNAME,
    SUM(SALES) AS total_revenue
FROM orders
GROUP BY CUSTOMERNAME
ORDER BY total_revenue DESC
LIMIT 5;


-- =====================================================
-- 2. Quarter-over-Quarter (QoQ) revenue growth
-- =====================================================
WITH quarterly_sales AS (
    SELECT
        YEAR_ID,
        QTR_ID,
        SUM(SALES) AS total_sales
    FROM orders
    GROUP BY YEAR_ID, QTR_ID
)
SELECT
    YEAR_ID,
    QTR_ID,
    total_sales AS current_sales,
    LAG(total_sales) OVER (ORDER BY YEAR_ID, QTR_ID) AS previous_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY YEAR_ID, QTR_ID))
        * 100.0 /
        LAG(total_sales) OVER (ORDER BY YEAR_ID, QTR_ID),
        2
    ) AS qoq_growth_percent
FROM quarterly_sales
ORDER BY YEAR_ID, QTR_ID;


-- =====================================================
-- 3. Product performance by region (Territory)
-- =====================================================
SELECT
    PRODUCTCODE,
    SUM(CASE WHEN TERRITORY = 'APAC' THEN SALES ELSE 0 END) AS apac_revenue,
    SUM(CASE WHEN TERRITORY = 'NA' THEN SALES ELSE 0 END) AS na_revenue,
    SUM(CASE WHEN TERRITORY = 'EMEA' THEN SALES ELSE 0 END) AS emea_revenue
FROM orders
GROUP BY PRODUCTCODE
ORDER BY PRODUCTCODE;


-- =====================================================
-- 4. Average order size by product line
-- =====================================================
SELECT
    PRODUCTLINE,
    ROUND(AVG(QUANTITYORDERED), 2) AS avg_order_quantity
FROM orders
GROUP BY PRODUCTLINE
ORDER BY avg_order_quantity DESC;


-- =====================================================
-- 5. Customer purchase frequency
-- =====================================================
SELECT
    CUSTOMERNAME,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders
FROM orders
GROUP BY CUSTOMERNAME
ORDER BY total_orders DESC;


-- =====================================================
-- 6. Seasonal trends (monthly revenue across years)
-- =====================================================
SELECT
    YEAR_ID,
    MONTH_ID,
    SUM(SALES) AS monthly_revenue
FROM orders
GROUP BY YEAR_ID, MONTH_ID
ORDER BY YEAR_ID, MONTH_ID;


-- =====================================================
-- 7. Deal size distribution (percentage of orders)
-- =====================================================
SELECT
    DEALSIZE,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage
FROM orders
GROUP BY DEALSIZE
ORDER BY percentage DESC;
