-- =====================================================
-- Geography Dimension
-- =====================================================
-- Stores unique customer geographic locations.
-- Used to support regional and location-based analysis.
-- =====================================================

CREATE TABLE dim_geography (
    geography_key INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    zipcode VARCHAR(20)
);