# Supply Chain Analytics

## Project Overview

This project demonstrates an end-to-end Supply Chain Analytics solution built using Python, MySQL, SQL, and Power BI.

The project follows the complete analytics workflow:

Raw Dataset → Data Cleaning → Data Warehouse Design → ETL Process → Business Analysis → Interactive Dashboarding

A dimensional data warehouse was designed using a Star Schema to support analytical reporting and business intelligence.

---

## Objectives

The primary objectives of this project were to:

- Clean and validate raw supply chain data
- Design a scalable dimensional data warehouse
- Perform ETL processes using SQL
- Analyze sales, customers, products, shipping, and geographic performance
- Build interactive Power BI dashboards for business decision-making
- Generate actionable business insights from transactional data

---

## Tech Stack

| Technology | Purpose |
|------------|----------|
| Python | Data Cleaning & Exploration |
| Pandas | Data Processing |
| NumPy | Data Manipulation |
| Matplotlib | Visualization |
| MySQL | Data Warehouse & ETL |
| SQL | Business Analysis |
| Power BI | Dashboard Development |
| GitHub | Version Control & Portfolio |

---

## Dataset

Source: DataCo Global Supply Chain Dataset

Dataset Size:

- 180,519 Records
- 53 Columns
- Multi-country Supply Chain Operations

Key Areas:

- Customers
- Products
- Orders
- Shipping
- Geography
- Sales
- Profit

---

## Project Workflow

```text
Raw CSV Dataset
        │
        ▼
Python Data Cleaning
        │
        ▼
MySQL Staging Table
        │
        ▼
Clean Supply Chain Table
        │
        ▼
Star Schema Data Warehouse
        │
        ▼
Business Analysis Queries
        │
        ▼
Power BI Dashboards
```

---

## Data Warehouse Architecture

The warehouse follows a Star Schema design.

### Fact Table

- fact_order_items

### Dimension Tables

- dim_customer
- dim_product
- dim_date
- dim_shipping
- dim_geography

Insert Star Schema Diagram Here

---

## Python Analysis

Python was used for:

- Data Exploration
- Missing Value Analysis
- Duplicate Detection
- Data Quality Assessment
- Feature Engineering
- Data Cleaning
- Exporting Clean Dataset

### Key Findings

- Product Description contained 100% missing values
- Order Zipcode contained 86% missing values
- Customer-related fields had minimal missing data
- No significant duplicate transaction records were found

---

## SQL Data Warehouse

### ETL Process

- Raw data imported into staging table
- Data standardized and cleaned
- Dimensional model created
- Surrogate keys generated
- Fact table populated through dimension mapping
- Data validation checks performed

### SQL Concepts Used

- Joins
- CTEs
- Window Functions
- Aggregate Functions
- Data Validation Queries
- Ranking Functions
- Date Functions

---

## Business Analysis

### Sales Performance

- Total Sales
- Total Profit
- Average Order Value
- Total Orders

### Customer Analysis

- Top Customers
- Customer Segmentation
- Repeat vs One-Time Customers
- Pareto Analysis (Top 20% Customers)

### Product Analysis

- Top Selling Products
- Most Profitable Products
- Category Profitability
- Department Profitability

### Geographic Analysis

- Sales by Country
- Sales by Region
- Sales by Market

### Shipping Analysis

- Delivery Performance
- Late Delivery Risk
- Shipping Mode Performance

### Time Analysis

- Monthly Sales Trend
- Year-over-Year Growth
- Quarter-over-Quarter Growth
- Monthly Growth Rate

---

## Power BI Dashboard

The dashboard consists of four analytical pages.

### Executive Dashboard

* **Executive Overview:** ![Executive Overview](https://github.com/vraj2602/Regional-Sales-Analysis/blob/main/Executive%20Overview%20%26%20Trends.png?raw=true)

Features:

- Revenue KPI
- Profit KPI
- Orders KPI
- Customers KPI
- Sales Trend Analysis

---

### Customer Analytics

* **Executive Overview:** ![Executive Overview](https://github.com/vraj2602/Regional-Sales-Analysis/blob/main/Executive%20Overview%20%26%20Trends.png?raw=true)

Features:

- Customer Segmentation
- Top Customers
- Customer Distribution
- Repeat vs One-Time Customers
- Pareto Analysis

---

### Product Analytics

* **Executive Overview:** ![Executive Overview](https://github.com/vraj2602/Regional-Sales-Analysis/blob/main/Executive%20Overview%20%26%20Trends.png?raw=true)

Features:

- Product Performance
- Category Analysis
- Department Analysis
- Profitability Analysis

---

### Shipping Analytics

* **Executive Overview:** ![Executive Overview](https://github.com/vraj2602/Regional-Sales-Analysis/blob/main/Executive%20Overview%20%26%20Trends.png?raw=true)

Features:

- Delivery Status
- Shipping Performance
- Late Delivery Risk
- Shipping Mode Analysis

---

## Key Business Insights

### Revenue Concentration

Top 20% of customers contribute a significant percentage of overall revenue, confirming the Pareto Principle.

### Customer Retention

Repeat customers generate substantially higher revenue than one-time customers.

### Product Performance

A small number of products account for a large share of total sales and profit.

### Shipping Risk

A notable percentage of orders are exposed to late delivery risk, highlighting opportunities for logistics optimization.

### Geographic Performance

Revenue is concentrated within a few high-performing markets and regions.

---

## Repository Structure

```text
Supply-Chain-Analytics
│
├── Dataset
├── Images
├── Power BI
├── Python
├── SQL
└── README.md
```

---

## How to Run

### Python

Run:

```python
Supply_Chain_Analysis.ipynb
```

### SQL

Execute SQL scripts sequentially:

1. Data Profiling
2. Clean Table Creation
3. Dimension Creation
4. Fact Table Creation
5. Business Analysis

### Power BI

Open:

```text
Supply Chain Analysis.pbix
```

Refresh data connection if required.

---

## Future Improvements

- Automated ETL Pipeline
- Advanced Forecasting Models
- Customer Lifetime Value Analysis
- Inventory Optimization Analysis
- Real-Time Dashboard Integration

---

## Author

Viraj Bhosale

**LinkedIn:** [Viraj Bhosale Profile](https://www.linkedin.com/in/viraj-bhosale-b9125a377?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)

Skills:
SQL | Python | Power BI | Excel | Data Warehousing | ETL | Data Visualization
