-- Load Geography Dimension

INSERT INTO dim_geography (
    city,
    state,
    country,
    zipcode
)
SELECT DISTINCT
    customer_city,
    customer_state,
    customer_country,
    customer_zipcode
FROM clean_supply_chain;

