-- =====================================================
-- Customer Dimension
-- =====================================================
-- Stores unique customer information.
-- Uses a surrogate key (customer_key) and links to
-- dim_geography through geography_key.
-- =====================================================
CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT UNIQUE,
    customer_fname VARCHAR(100),
    customer_lname VARCHAR(100),
    customer_segment VARCHAR(100),
    latitude DOUBLE,
    longitude DOUBLE,
    geography_key INT,
    FOREIGN KEY (geography_key)
        REFERENCES dim_geography(geography_key)
);
