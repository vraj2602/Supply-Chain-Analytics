-- =====================================================
-- Fact Table: Order Items
-- =====================================================
-- Stores transactional sales records.
-- Each row represents a single order item and links
-- to all dimensions using surrogate keys.
-- =====================================================
CREATE TABLE fact_order_items (
    fact_key INT PRIMARY KEY AUTO_INCREMENT,

    order_item_id INT,
    order_id INT,

    customer_key INT,
    product_key INT,
    order_date_key INT,
    shipping_date_key INT,
    shipping_key INT,
    geography_key INT,

    market VARCHAR(100),
    order_region VARCHAR(100),
    order_status VARCHAR(100),

    order_item_quantity INT,
    product_price DECIMAL(10,2),
    order_item_discount DECIMAL(10,2),
    order_item_discount_rate DOUBLE,
    sales DECIMAL(10,2),
    order_item_total DECIMAL(10,2),
    benefit_per_order DECIMAL(10,2),
    order_profit_per_order DECIMAL(10,2),
    order_item_profit_ratio DOUBLE,

    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (order_date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (shipping_date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (shipping_key) REFERENCES dim_shipping(shipping_key),
    FOREIGN KEY (geography_key) REFERENCES dim_geography(geography_key)
);