USE SupplyChainAnalytics;

-- =====================================================
-- Load Fact Table
-- =====================================================
-- This script:
-- 1. Verifies that every transaction successfully maps
--    to the corresponding dimension tables.
-- 2. Loads the fact_order_items table using surrogate keys.
-- =====================================================


-- =====================================================
-- Step 1: Preview Dimension Mapping
-- =====================================================
-- Verify that the joins return the expected surrogate keys
-- before loading the fact table.

SELECT
    c.order_item_id,
    c.order_id,

    -- Dimension Keys
    dc.customer_key,
    dp.product_key,
    od.date_key AS order_date_key,
    sd.date_key AS shipping_date_key,
    ds.shipping_key,
    dg.geography_key,

    -- Business Attributes
    c.market,
    c.order_region,
    c.order_status,

    -- Measures
    c.order_item_quantity,
    c.product_price,
    c.order_item_discount,
    c.order_item_discount_rate,
    c.sales,
    c.order_item_total,
    c.benefit_per_order,
    c.order_profit_per_order,
    c.order_item_profit_ratio

FROM clean_supply_chain c

JOIN dim_customer dc
    ON c.customer_id = dc.customer_id

JOIN dim_product dp
    ON c.product_card_id = dp.product_card_id

JOIN dim_date od
    ON DATE(c.order_date) = od.full_date

JOIN dim_date sd
    ON DATE(c.shipping_date) = sd.full_date

JOIN dim_shipping ds
    ON c.shipping_mode = ds.shipping_mode
   AND c.days_for_shipping = ds.days_for_shipping
   AND c.days_for_shipment = ds.days_for_shipment
   AND c.delivery_status = ds.delivery_status
   AND c.late_delivery_risk = ds.late_delivery_risk

JOIN dim_geography dg
    ON c.customer_city = dg.city
   AND c.customer_state = dg.state
   AND c.customer_country = dg.country
   AND c.customer_zipcode = dg.zipcode

LIMIT 20;


-- =====================================================
-- Step 2: Validate Dimension Mapping
-- =====================================================
-- Expected Result: 180516
-- Every transaction should successfully map to all
-- dimension tables before loading.

SELECT COUNT(*) AS RecordsReadyForLoad

FROM clean_supply_chain c

JOIN dim_customer dc
    ON c.customer_id = dc.customer_id

JOIN dim_product dp
    ON c.product_card_id = dp.product_card_id

JOIN dim_date od
    ON DATE(c.order_date) = od.full_date

JOIN dim_date sd
    ON DATE(c.shipping_date) = sd.full_date

JOIN dim_shipping ds
    ON c.shipping_mode = ds.shipping_mode
   AND c.days_for_shipping = ds.days_for_shipping
   AND c.days_for_shipment = ds.days_for_shipment
   AND c.delivery_status = ds.delivery_status
   AND c.late_delivery_risk = ds.late_delivery_risk

JOIN dim_geography dg
    ON c.customer_city = dg.city
   AND c.customer_state = dg.state
   AND c.customer_country = dg.country
   AND c.customer_zipcode = dg.zipcode;


-- =====================================================
-- Step 3: Load Fact Table
-- =====================================================

INSERT INTO fact_order_items (

    order_item_id,
    order_id,

    customer_key,
    product_key,
    order_date_key,
    shipping_date_key,
    shipping_key,
    geography_key,

    market,
    order_region,
    order_status,

    order_item_quantity,
    product_price,
    order_item_discount,
    order_item_discount_rate,
    sales,
    order_item_total,
    benefit_per_order,
    order_profit_per_order,
    order_item_profit_ratio

)

SELECT

    -- Transaction Identifiers
    c.order_item_id,
    c.order_id,

    -- Dimension Keys
    dc.customer_key,
    dp.product_key,
    od.date_key,
    sd.date_key,
    ds.shipping_key,
    dg.geography_key,

    -- Business Attributes
    c.market,
    c.order_region,
    c.order_status,

    -- Measures
    c.order_item_quantity,
    c.product_price,
    c.order_item_discount,
    c.order_item_discount_rate,
    c.sales,
    c.order_item_total,
    c.benefit_per_order,
    c.order_profit_per_order,
    c.order_item_profit_ratio

FROM clean_supply_chain c

JOIN dim_customer dc
    ON c.customer_id = dc.customer_id

JOIN dim_product dp
    ON c.product_card_id = dp.product_card_id

JOIN dim_date od
    ON DATE(c.order_date) = od.full_date

JOIN dim_date sd
    ON DATE(c.shipping_date) = sd.full_date

JOIN dim_shipping ds
    ON c.shipping_mode = ds.shipping_mode
   AND c.days_for_shipping = ds.days_for_shipping
   AND c.days_for_shipment = ds.days_for_shipment
   AND c.delivery_status = ds.delivery_status
   AND c.late_delivery_risk = ds.late_delivery_risk

JOIN dim_geography dg
    ON c.customer_city = dg.city
   AND c.customer_state = dg.state
   AND c.customer_country = dg.country
   AND c.customer_zipcode = dg.zipcode;