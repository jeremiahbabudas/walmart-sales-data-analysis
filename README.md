# Walmart Sales Data Analysis Project

## 📊 Project Overview

This project analyzes Walmart sales data using SQL Server Management Studio (SSMS) and Power BI to extract business insights and visualize sales performance across regions, customer segments, and product categories.

**Key Goals:**
- Perform sales, profit, and operational analysis using SQL queries.
- Visualize insights through an interactive Power BI dashboard.
- Identify top-performing products, customer segments, and regional trends.


## 📁 Data Sources

- `Customers.xlsx`
- `Orders.xlsx`
- `Products.xlsx`

These Excel files were imported into SQL Server for structured querying.


## 🛠️ Tools Used

- **SQL Server Management Studio (SSMS)** – Data querying and analysis.
- **Power BI Desktop** – Data visualization and dashboard creation.
- **Excel** – Initial data files.


## 🔍 SQL Analysis Highlights

- Total sales and profit per month.
- Sales, quantity, discounts, and profit analysis per category and sub-category.
- Identification of products generating negative profits.
- Top 10 loss-making orders.
- Average shipping time (Turnaround Time).
- Customer segment-wise revenue contribution.
- Regional order distribution.
- Profit margin analysis by product and region.

> SQL scripts are available in the repository for review.


## 📊 Power BI Dashboard Features

- **Slicers:**  
  - Region  
  - Segment  
  - State  

- **KPI Cards:**  
  - Total Sales  
  - Number of Orders  
  - Average TAT (Turnaround Time)  
  - Average Profit  

- **Visuals:**  
  - **Donut Chart** – Sales by Category (Technology, Office Supplies, Furniture).  
  - **Clustered Bar Chart** – Top 10 Products by Profitability.  
  - **Stacked Column Chart** – Profit by Segment and Category.  
  - **Line Chart** – Sales Trends by Year.

- **Data Cleaning:**  
  - Duplicate entries removed from Customers and Products using Power BI’s Transform Data step.  
  - Appropriate model relationships created between tables.


## 📷 Screenshots

*(Include screenshots of your dashboard here)*


## 📈 Key Insights

- Technology category leads in both sales and profit.
- Corporate and Consumer segments drive major sales.
- Certain products consistently report negative profits, indicating potential pricing or discounting issues.
- Average shipping turnaround time is [insert your calculated value] days.
