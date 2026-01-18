-- =====================================================
-- Retail Sales Performance Analysis
-- File: basic_analysis.sql
-- Description: Foundational SQL queries to analyze
--              overall sales performance and KPIs
-- Dataset: sales_data_cleaned.csv
-- Table: orders
-- =====================================================


-- =====================================================
-- 1. Revenue by Year
-- =====================================================
SELECT
    YEAR_ID AS year,
    SUM(SALES) AS total_revenue
FROM orders
GROUP BY YEAR_ID
ORDER BY YEAR_ID;


-- =====================================================
-- 2. Top 10 Products by Revenue
-- =====================================================
SELECT
    PRODUCTCODE,
    SUM(SALES) AS revenue
FROM orders
GROUP BY PRODUCTCODE
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- 3. Total Revenue by Product Line
-- =====================================================
SELECT
    PRODUCTLINE,
    SUM(SALES) AS total_revenue
FROM orders
GROUP BY PRODUCTLINE
ORDER BY total_revenue DESC;


-- =====================================================
-- 4. Total Revenue by Country
-- =====================================================
SELECT
    COUNTRY,
    SUM(SALES) AS total_revenue
FROM orders
GROUP BY COUNTRY
ORDER BY total_revenue DESC;


-- =====================================================
-- 5. Number of Orders by Status
-- =====================================================
SELECT
    STATUS,
    COUNT(DISTINCT ORDERNUMBER) AS number_of_orders
FROM orders
GROUP BY STATUS
ORDER BY number_of_orders DESC;


-- =====================================================
-- 6. Average Order Value by Deal Size
-- =====================================================
SELECT
    DEALSIZE,
    ROUND(AVG(SALES), 2) AS average_order_value
FROM orders
GROUP BY DEALSIZE
ORDER BY average_order_value DESC;


-- =====================================================
-- 7. Monthly Revenue Trend for 2004
-- =====================================================
SELECT
    MONTH_ID,
    SUM(SALES) AS monthly_revenue
FROM orders
WHERE YEAR_ID = 2004
GROUP BY MONTH_ID
ORDER BY MONTH_ID;
