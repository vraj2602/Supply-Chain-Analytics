-- Load Shipping Dimension

INSERT INTO dim_shipping (
    shipping_mode,
    days_for_shipping,
    days_for_shipment,
    delivery_status,
    late_delivery_risk
)
SELECT DISTINCT
    shipping_mode,
    days_for_shipping,
    days_for_shipment,
    delivery_status,
    late_delivery_risk
FROM clean_supply_chain;

-- Validation
SELECT COUNT(*)
FROM dim_shipping;