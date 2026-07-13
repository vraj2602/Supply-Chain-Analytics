-- =====================================================
-- Shipping Dimension
-- =====================================================
-- Stores unique shipping characteristics including
-- shipping mode, delivery status, scheduled and actual
-- shipping days, and late delivery risk.
-- =====================================================

CREATE TABLE dim_shipping (
    shipping_key INT PRIMARY KEY AUTO_INCREMENT,
    shipping_mode VARCHAR(30) NOT NULL,
    days_for_shipping INT NOT NULL,
    days_for_shipment INT NOT NULL,
    delivery_status VARCHAR(50) NOT NULL,
    late_delivery_risk INT NOT NULL
);