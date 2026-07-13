-- Load Product Dimension

INSERT INTO dim_product (
    product_card_id,
    product_name,
    product_description,
    product_price,
    product_status,
    category_id,
    category_name,
    department_id,
    department_name
)
SELECT DISTINCT
    product_card_id,
    product_name,
    product_description,
    product_price,
    product_status,
    category_id,
    category_name,
    department_id,
    department_name
FROM clean_supply_chain;

-- Validation

SELECT COUNT(*) AS TotalProducts
FROM dim_product;
