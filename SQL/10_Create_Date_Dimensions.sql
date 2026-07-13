-- =====================================================
-- Date Dimension
-- =====================================================
-- Stores calendar attributes used for time intelligence
-- analysis including month, quarter, year, weekday,
-- and weekend flag.
-- =====================================================

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(15) NOT NULL,
    quarter VARCHAR(2) NOT NULL,
    year INT NOT NULL,
    day_of_week VARCHAR(15) NOT NULL,
    weekend_flag VARCHAR(3) NOT NULL
);
