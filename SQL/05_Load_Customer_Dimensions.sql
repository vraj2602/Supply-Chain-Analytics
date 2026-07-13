INSERT INTO dim_customer
(
    customer_id,
    customer_fname,
    customer_lname,
    customer_segment,
    latitude,
    longitude,
    geography_key
)
SELECT
    c.customer_id,
    MIN(c.customer_fname),
    MIN(c.customer_lname),
    MIN(c.customer_segment),
    AVG(c.latitude),
    AVG(c.longitude),
    g.geography_key
FROM clean_supply_chain c
JOIN dim_geography g
    ON c.customer_city = g.city
   AND c.customer_state = g.state
   AND c.customer_country = g.country
   AND c.customer_zipcode = g.zipcode
GROUP BY
    c.customer_id,
    g.geography_key;
    
-- Customer Validation
SELECT COUNT(*) AS total_customers
FROM dim_customer;

SELECT COUNT(DISTINCT customer_id)
FROM dim_customer;

SELECT
    customer_id,
    COUNT(*)
FROM dim_customer
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT *
FROM dim_customer
WHERE geography_key IS NULL;