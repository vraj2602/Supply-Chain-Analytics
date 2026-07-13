-- CREATING DATABASE
CREATE DATABASE SupplyChainAnalytics;
USE SupplyChainAnalytics;

-- CHECK DATASET
SELECT *
FROM stg_supply_chain
LIMIT 10;

-- SECTION 1: DATASET OVERVIEW
-- 1. Total records
select 
count(*) as TotalRecords
from stg_supply_chain;

-- 2. Total distinct customers
select 
count(distinct `customer id`) as Total_distinct_Customer
from stg_supply_chain;

-- 3.Total distinct orders
select 
count(distinct `order id`) as Total_distinct_orders
from stg_supply_chain;

-- 4. Total distinct products
select 
count(distinct `product card id`) as Total_distinct_products
from stg_supply_chain;

-- 5. Total distinct categories
select 
count(distinct `category id`) as Total_distinct_categories
from stg_supply_chain;

-- 6. Total distinct departments
select 
count(distinct `department id`) as Total_distinct_departments
from stg_supply_chain;

-- SECTION 2: UNIQUENESS VALIDATION

-- 7. Is Order Item Id unique?
-- Yes. Because it proves your future primary key.
select 
`Order Item id`,
count(*) as OrderItemCount
from stg_supply_chain
group by `Order Item id`
having count(*) > 1;

-- 8. Show duplicate Order Ids.
-- One order can contain multiple products.
select 
`Order id`,
count(*) as OrderIdCount
from stg_supply_chain
group by `Order id`
having count(*) > 1;

-- 9. Are there duplicate customer emails?
-- Customer email values are masked in the source dataset,
-- therefore duplicate email validation is not meaningful.
select 
`customer Email`,
count(*) as EmailCount
from stg_supply_chain
group by `customer Email`
having count(*) > 1;

-- SECTION 3: MISSING VALUE ANALYSIS

-- 10. Nulls For Customer Email
select 
`customer Email`
from stg_supply_chain
where `customer Email` is null;

-- 11. Nulls For Customer Fname
select 
`customer Fname`
from stg_supply_chain
where `customer Fname` is null;

-- 12. Nulls for Customer Lname
select 
`customer Lname`
from stg_supply_chain
where `customer Lname` is null;

-- 13. Nulls for Customer Zipcode
select 
`Customer Zipcode`
from stg_supply_chain
where `Customer Zipcode` is null;

-- 14. Nulls for Product Description
select 
`Product Description`
from stg_supply_chain
where `Product Description` is null;

-- 15. Nulls for Shipping Date
select 
`shipping date (DateOrders)`
from stg_supply_chain
where `shipping date (DateOrders)` is null;

-- 16. Nulls for Order Date
select 
`order date (DateOrders)`
from stg_supply_chain
where `order date (DateOrders)` is null;

-- SECTION 4: DATA QUALITY VALIDATION

-- 17. Are there negative Sales?
-- There are no negative sales
select 
Sales
from stg_supply_chain
where Sales < 0;

-- 18. Are there negative Quantities?
-- There are no negative quantities
select 
`Order Item Quantity`
from stg_supply_chain
where `Order Item Quantity` < 0;

-- 19. Are there Discounts greater than Sales?
select 
`Order Item Discount`
from stg_supply_chain
where `Order Item Discount` > Sales;

-- 20. Are there Products with a price of 0?
-- There are no products with 0 price
select 
`Product Card Id`,
`Product Category Id`
from stg_supply_chain
where `Product Price` = 0 ;

-- 21. Are there Shipping Days less than 0?
-- No there is no order with shipping days less than 0
select 
`Days for shipping (real)`
from stg_supply_chain
where `Days for shipping (real)` < 0


