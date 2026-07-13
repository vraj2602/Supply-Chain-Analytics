-- =====================================================
-- Load Date Dimension
-- Generates calendar dates from 2010-01-01 to
-- 2030-12-31 using a recursive CTE.
-- =====================================================
SET SESSION cte_max_recursion_depth = 10000;

INSERT INTO dim_date
(date_key,
full_date,
day,
month,
month_name,
quarter,
year,
day_of_week,
weekend_flag)
WITH RECURSIVE calendar AS
(
    SELECT DATE('2010-01-01') AS dt
    UNION ALL
    SELECT DATE_ADD(dt, INTERVAL 1 DAY)
    FROM calendar
    WHERE dt < '2030-12-31'
)
SELECT
    DATE_FORMAT(dt,'%Y%m%d') + 0,
    dt,
    DAY(dt),
    MONTH(dt),
    MONTHNAME(dt),
    CONCAT('Q',QUARTER(dt)),
    YEAR(dt),
    DAYNAME(dt),
    CASE
        WHEN DAYOFWEEK(dt) IN (1,7) THEN 'Yes'
        ELSE 'No'
    END
FROM calendar;

-- Validation
SELECT COUNT(*)
FROM dim_date;
