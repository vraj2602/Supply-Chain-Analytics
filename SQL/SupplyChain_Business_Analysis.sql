USE SupplyChainAnalytics;

-- =====================================================
-- Business Analysis
-- =====================================================
-- This script contains business analysis queries built
-- on the dimensional model to answer key business
-- questions related to sales, customers, products,
-- geography, shipping, and time-based performance.
-- =====================================================


-- =====================================================
-- Section 1: Sales Performance
-- =====================================================

-- Total Sales

SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM fact_order_items;

-- Expected Result: 36,784,084.58


-- Total Profit

SELECT
    ROUND(SUM(order_profit_per_order), 2) AS total_profit
FROM fact_order_items;

-- Expected Result: 3,966,765.69


-- Total Orders

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM fact_order_items;

-- Expected Result: 65,749


-- Total Customers

SELECT
    COUNT(DISTINCT customer_key) AS total_customers
FROM fact_order_items;

-- Expected Result: 20,649


-- Average Order Value

SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM fact_order_items;

-- Expected Result: 559.46


-- =====================================================
-- Section 2: Customer Analysis
-- =====================================================

-- Top 10 Customers by Sales

SELECT
    CONCAT(dc.customer_fname,' ',dc.customer_lname) AS customer_name,
    ROUND(SUM(f.sales),2) AS total_sales
FROM fact_order_items f
JOIN dim_customer dc
ON f.customer_key = dc.customer_key
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- Sales by Customer Segment

SELECT
    dc.customer_segment,
    ROUND(SUM(f.sales),2) AS total_sales
FROM fact_order_items f
JOIN dim_customer dc
ON f.customer_key = dc.customer_key
GROUP BY dc.customer_segment
ORDER BY total_sales DESC;


-- Customer Count by Segment

SELECT
    customer_segment,
    COUNT(*) AS customers
FROM dim_customer
GROUP BY customer_segment;


-- =====================================================
-- Section 3: Product Analysis
-- =====================================================

-- Top 10 Products by Sales

SELECT
    dp.product_name,
    ROUND(SUM(f.sales),2) AS total_sales
FROM fact_order_items f
JOIN dim_product dp
ON f.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_sales DESC
LIMIT 10;


-- Top 10 Products by Profit

SELECT
    dp.product_name,
    ROUND(SUM(f.order_profit_per_order),2) AS total_profit
FROM fact_order_items f
JOIN dim_product dp
ON f.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_profit DESC
LIMIT 10;


-- =====================================================
-- Section 4: Time Analysis
-- =====================================================

-- Monthly Sales Trend

SELECT
    d.year,
    d.month_name,
    ROUND(SUM(f.sales),2) AS sales
FROM fact_order_items f
JOIN dim_date d
ON f.order_date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


-- Yearly Sales Trend

SELECT
    d.year,
    ROUND(SUM(f.sales),2) AS sales
FROM fact_order_items f
JOIN dim_date d
ON f.order_date_key = d.date_key
GROUP BY d.year
ORDER BY d.year;


-- =====================================================
-- Section 5: Geographic Analysis
-- =====================================================

-- Sales by Country

SELECT
    g.country,
    ROUND(SUM(f.sales),2) AS sales
FROM fact_order_items f
JOIN dim_geography g
ON f.geography_key = g.geography_key
GROUP BY g.country
ORDER BY sales DESC;


-- Sales by Market

SELECT
    market,
    ROUND(SUM(sales),2) AS sales
FROM fact_order_items
GROUP BY market
ORDER BY sales DESC;


-- Sales by Region

SELECT
    order_region,
    ROUND(SUM(sales),2) AS sales
FROM fact_order_items
GROUP BY order_region
ORDER BY sales DESC;


-- =====================================================
-- Section 6: Shipping Performance
-- =====================================================

-- Delivery Status Distribution

SELECT
    delivery_status,
    COUNT(*) AS orders
FROM fact_order_items f
JOIN dim_shipping ds
ON f.shipping_key = ds.shipping_key
GROUP BY delivery_status;


-- Late Delivery Percentage

SELECT
    ROUND(
        100 * SUM(CASE WHEN late_delivery_risk = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM fact_order_items f
JOIN dim_shipping ds
ON f.shipping_key = ds.shipping_key;


-- =====================================================
-- Section 7: Repeat vs One-Time Customer Analysis
-- =====================================================

-- Customer Count

WITH customer_orders AS
(
    SELECT
        customer_key,
        COUNT(DISTINCT order_id) AS total_orders
    FROM fact_order_items
    GROUP BY customer_key
)

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type;


-- Revenue by Customer Type

WITH customer_orders AS
(
    SELECT
        customer_key,
        COUNT(DISTINCT order_id) AS total_orders
    FROM fact_order_items
    GROUP BY customer_key
)

SELECT
    CASE
        WHEN co.total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    ROUND(SUM(f.sales),2) AS revenue
FROM fact_order_items f
JOIN customer_orders co
ON f.customer_key = co.customer_key
GROUP BY customer_type;


-- =====================================================
-- Section 8: Pareto Analysis (Top 20% Customers)
-- =====================================================

WITH customer_sales AS
(
    SELECT
        customer_key,
        SUM(sales) AS total_sales
    FROM fact_order_items
    GROUP BY customer_key
),
customer_rank AS
(
    SELECT
        customer_key,
        total_sales,
        ROW_NUMBER() OVER(ORDER BY total_sales DESC) AS customer_rank,
        COUNT(*) OVER() AS total_customers
    FROM customer_sales
)

SELECT
    COUNT(*) AS top_customers,
    ROUND(SUM(total_sales),2) AS revenue
FROM customer_rank
WHERE customer_rank <= CEILING(total_customers * 0.20);


WITH customer_sales AS
(
    SELECT
        customer_key,
        SUM(sales) AS total_sales
    FROM fact_order_items
    GROUP BY customer_key
),
customer_rank AS
(
    SELECT
        customer_key,
        total_sales,
        ROW_NUMBER() OVER(ORDER BY total_sales DESC) AS customer_rank,
        COUNT(*) OVER() AS total_customers,
        SUM(total_sales) OVER() AS company_sales
    FROM customer_sales
)

SELECT
    ROUND(
        100 * SUM(total_sales) / MAX(company_sales),
        2
    ) AS revenue_percentage
FROM customer_rank
WHERE customer_rank <= CEILING(total_customers * 0.20);


-- =====================================================
-- Section 9: Monthly Growth Rate
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        d.year,
        d.month,
        SUM(f.sales) AS sales
    FROM fact_order_items f
    JOIN dim_date d
    ON f.order_date_key = d.date_key
    GROUP BY
        d.year,
        d.month
)

SELECT
    year,
    month,
    ROUND(sales,2) AS monthly_sales,
    ROUND(
        100 *
        (
            sales -
            LAG(sales) OVER(ORDER BY year, month)
        )
        /
        LAG(sales) OVER(ORDER BY year, month),
        2
    ) AS growth_percentage
FROM monthly_sales;


-- =====================================================
-- Section 10: Year-over-Year Growth
-- =====================================================

WITH yearly_sales AS
(
    SELECT
        d.year,
        SUM(f.sales) AS sales
    FROM fact_order_items f
    JOIN dim_date d
    ON f.order_date_key = d.date_key
    GROUP BY d.year
)

SELECT
    year,
    ROUND(sales,2) AS yearly_sales,
    ROUND(
        100 *
        (
            sales -
            LAG(sales) OVER(ORDER BY year)
        )
        /
        LAG(sales) OVER(ORDER BY year),
        2
    ) AS yoy_growth
FROM yearly_sales;


-- =====================================================
-- Section 11: Quarter-over-Quarter Growth
-- =====================================================

WITH quarterly_sales AS
(
    SELECT
        d.year,
        d.quarter,
        SUM(f.sales) AS sales
    FROM fact_order_items f
    JOIN dim_date d
    ON f.order_date_key = d.date_key
    GROUP BY
        d.year,
        d.quarter
)

SELECT
    year,
    quarter,
    ROUND(sales,2) AS quarterly_sales,
    ROUND(
        100 *
        (
            sales -
            LAG(sales) OVER(ORDER BY year, quarter)
        )
        /
        LAG(sales) OVER(ORDER BY year, quarter),
        2
    ) AS qoq_growth
FROM quarterly_sales;


-- =====================================================
-- Section 12: Category Profitability
-- =====================================================

SELECT
    dp.category_name,
    ROUND(SUM(f.sales),2) AS sales,
    ROUND(SUM(f.order_profit_per_order),2) AS profit,
    ROUND(
        100 * SUM(f.order_profit_per_order)
        / SUM(f.sales),
        2
    ) AS profit_margin
FROM fact_order_items f
JOIN dim_product dp
ON f.product_key = dp.product_key
GROUP BY dp.category_name
ORDER BY profit DESC;


-- =====================================================
-- Section 13: Department Profitability
-- =====================================================

SELECT
    dp.department_name,
    ROUND(SUM(f.sales),2) AS sales,
    ROUND(SUM(f.order_profit_per_order),2) AS profit,
    ROUND(
        100 * SUM(f.order_profit_per_order)
        / SUM(f.sales),
        2
    ) AS profit_margin
FROM fact_order_items f
JOIN dim_product dp
ON f.product_key = dp.product_key
GROUP BY dp.department_name
ORDER BY profit DESC;


-- =====================================================
-- End of Business Analysis
-- =====================================================