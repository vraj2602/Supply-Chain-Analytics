-- =====================================================
-- Product Dimension
-- =====================================================
-- Stores unique product information including category
-- and department details.
-- =====================================================

CREATE TABLE dim_product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_card_id INT NOT NULL UNIQUE,
    product_name VARCHAR(100),
    product_description TEXT,
    product_price DECIMAL(10,2),
    product_status INT,
    category_id INT,
    category_name VARCHAR(100),
    department_id INT,
    department_name VARCHAR(100)
);