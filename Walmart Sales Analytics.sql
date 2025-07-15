-- Selecting correct database

USE WalmartSalesData

-- Selecting all the tables

SELECT *
FROM Customers

SELECT *
FROM Orders

SELECT *
FROM Products

-- What is the total sales and profit per month?

SELECT SUM(Sales) AS SumSales, SUM(Profit) AS SumProfit
FROM Orders

-- Sales, Quantity, Discount, Profit per category AND per sub-category

SELECT p.Category, SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Discount) AS SumDiscount, SUM(Profit) AS SumProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
GROUP BY p.Category

SELECT p.[Sub-Category], SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Discount) AS SumDiscount, SUM(Profit) AS SumProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
GROUP BY p.[Sub-Category]

--- Combining both the queries for getting profit per category AND per sub-category

SELECT p.Category, p.[Sub-Category], SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Discount) AS SumDiscount, SUM(Profit) AS SumProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
GROUP BY p.Category, p.[Sub-Category]

-- Unique product sales 

SELECT TOP 10 p.[Product Name], p.[Sub-Category], p.Category, SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Discount) AS SumDiscount, SUM(Profit) AS SumProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
GROUP BY p.[Product Name], p.[Sub-Category], p.Category
ORDER BY SumSales DESC;

-- Selected products with negative sumprofit

SELECT DISTINCT(p.[Product Name]), p.[Sub-Category], p.Category, SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Discount) AS SumDiscount, SUM(Profit) AS SumProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
GROUP BY p.[Product Name], p.[Sub-Category], p.Category
HAVING SUM(Profit) < 0

-- Selected top 10 orders with highest loss

SELECT TOP 10 *
FROM Orders
WHERE Profit < 0
ORDER BY PROFIT

-- What is the average discount applied across all orders?

SELECT AVG(Discount) AS AverageDiscount
FROM Orders

-- How many days on average does it take to ship an order?

SELECT AVG(DATEDIFF(DAY, [Order Date], [Ship Date])) AS AvgTAT
FROM Orders

-- Which customer segment generates the most revenue?

SELECT c.Segment, SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Profit) AS SumProfit
FROM Customers c
JOIN Orders o
ON c.[Customer id] = o.[Customer id]
GROUP BY c.Segment

SELECT TOP 1 c.Segment, SUM(Sales) AS SumSales, SUM(Quantity) AS SumQuantity, SUM(Profit) AS SumProfit
FROM Customers c
JOIN Orders o
ON c.[Customer Id] = o.[Customer Id]
GROUP BY c.Segment
ORDER BY SumProfit DESC

-- Which region has the highest number of orders?

SELECT c.region, COUNT([Order ID]) AS NumOrders
FROM Customers c
JOIN Orders o
ON c.[Customer Id] = o.[Customer Id]
GROUP BY c.region

SELECT TOP 1 c.region, COUNT([Order ID]) AS NumOrders
FROM Customers c
JOIN Orders o
ON c.[Customer Id] = o.[Customer Id]
GROUP BY c.region
ORDER BY NumOrders DESC

-- Who are the top 5 customers by total spending?

SELECT TOP 5 c.[Customer Name], SUM(Sales) AS SumSales
FROM Customers c
JOIN Orders o
ON c.[Customer Id] = o.[Customer Id]
GROUP BY c.[Customer Name]
ORDER BY SumSales DESC

-- Which cities have the highest average profit per order?

SELECT TOP 5 c.City, AVG(Profit) AS AvgProfit
FROM Customers c
JOIN Orders o
ON c.[Customer Id] = o.[Customer Id]
GROUP BY c.city
ORDER BY AvgProfit DESC

-- What is the average discount given to each customer segment?

SELECT c.Segment, AVG(Discount) AS AvgDiscount
FROM Customers c
JOIN Orders o
ON c.[Customer Id] = o.[Customer Id]
GROUP BY c.Segment

-- Which product categories have the highest sales and profit?

SELECT TOP 3 p.Category, SUM(Sales) AS SumSales -- change to 1 for highest
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
GROUP BY p.Category
ORDER BY SumSales DESC

SELECT TOP 3 p.Category, SUM(Profit) AS SumProfit -- change to 1 for highest
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
GROUP BY p.Category
ORDER BY SumProfit DESC

-- Which sub-category has the lowest profit margin? (Profit / Sales)

SELECT TOP 1 p.[Sub-Category], SUM(o.profit/o.sales) AS ProfitMargin
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
GROUP BY p.[Sub-Category]
ORDER BY ProfitMargin DESC

-- What is the average quantity sold per product?

SELECT p.[Product Name], AVG(o.Quantity) AS AvgQuantity
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
GROUP BY p.[Product Name]

-- Which products are most frequently sold?

SELECT p.[Product Name], COUNT(p.[Product Name]) AS NumProduct -- How many individual order lines each product appears in
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
GROUP BY p.[Product Name]

SELECT p.[Product Name], SUM(o.Quantity) AS NumQuantity -- How many units of each product were sold in total
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
GROUP BY p.[Product Name]

-- Which product-category and region combinations are the most profitable? - Technology for all regions

SELECT TOP 5 p.Category, c.Region, o.Profit
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
JOIN Customers c
ON o.[Customer ID] = c.[Customer ID]
WHERE c.Region = 'South'
ORDER BY o.Profit DESC

-- Which customer segment buys which categories the most? / Corporate - Office Supplies,  Home Office - Furniture, Consumer - Office Supplies

SELECT DISTINCT(c.Segment)
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
JOIN Customers c
ON o.[Customer ID] = c.[Customer ID]

SELECT TOP 10 c.Segment, p.Category, o.Quantity
FROM Products p
JOIN Orders o
ON p.[Product ID] = o.[Product ID]
JOIN Customers c
ON o.[Customer ID] = c.[Customer ID]
WHERE c.Segment = 'Consumer'
ORDER BY o.Quantity DESC

-- ChatGPT answer **********

SELECT c.Segment, p.Category, SUM(o.Quantity) AS TotalQuantity
FROM Orders o
JOIN Products p 
ON o.[Product ID] = p.[Product ID]
JOIN Customers c 
ON o.[Customer ID] = c.[Customer ID]
GROUP BY c.Segment, p.Category
ORDER BY c.Segment, TotalQuantity DESC;

-- How does discount affect profit across different product categories?

SELECT 
p.Category, AVG(o.Discount) AS AvgDiscount, AVG(o.Profit) AS AvgProfit, SUM(o.Sales) AS TotalSales, SUM(o.Profit) AS TotalProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
GROUP BY p.Category
ORDER BY AvgDiscount DESC;

-- Which products are popular in each region? **********

WITH RankedProducts AS (
SELECT p.[Product Name], c.Region, SUM(o.Quantity) AS TotalQty, ROW_NUMBER() OVER (PARTITION BY c.Region ORDER BY SUM(o.Quantity) DESC) AS rn
FROM Orders o
JOIN Products p 
ON o.[Product ID] = p.[Product ID]
JOIN Customers c 
ON o.[Customer ID] = c.[Customer ID]
GROUP BY c.Region, p.[Product Name]
)
SELECT *
FROM RankedProducts
WHERE rn <= 5
ORDER BY Region, TotalQty DESC;

-- Which ship mode is most used per region and how does it affect delivery time?

SELECT c.Region, o.[Ship Mode], COUNT(o.[Ship Mode]) AS QtyShipMode, AVG(DATEDIFF(DAY, [Order Date], [Ship Date])) AS AvgTAT
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
JOIN Customers c 
ON o.[Customer ID] = c.[Customer ID]
GROUP BY c.Region, o.[Ship Mode]
ORDER BY c.Region, o.[Ship Mode]

-- What is the total profit generated by each combination of Category + Segment + Region?

SELECT p.Category, c.Segment, c.Region, SUM(o.Profit) as SumProfit
FROM Orders o
JOIN Products p
ON o.[Product ID] = p.[Product ID]
JOIN Customers c 
ON o.[Customer ID] = c.[Customer ID]
GROUP BY p.Category, c.Segment, c.Region
ORDER BY p.Category, c.Segment, c.Region

-- 1. Top-Selling Products Per Region (by Quantity)

WITH TopProductsPerRegion AS (
  SELECT 
    c.Region,
    p.[Product Name],
    SUM(o.Quantity) AS TotalQty,
    ROW_NUMBER() OVER (PARTITION BY c.Region ORDER BY SUM(o.Quantity) DESC) AS rn
  FROM Orders o
  JOIN Products p ON o.[Product ID] = p.[Product ID]
  JOIN Customers c ON o.[Customer ID] = c.[Customer ID]
  GROUP BY c.Region, p.[Product Name]
)
SELECT * 
FROM TopProductsPerRegion
WHERE rn <= 5
ORDER BY Region, TotalQty DESC;

-- 2. Profitability by Category & Segment

WITH ProfitByCategorySegment AS (
  SELECT 
    p.Category,
    c.Segment,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit,
    SUM(o.Profit)/NULLIF(SUM(o.Sales), 0) AS ProfitMargin
  FROM Orders o
  JOIN Products p ON o.[Product ID] = p.[Product ID]
  JOIN Customers c ON o.[Customer ID] = c.[Customer ID]
  GROUP BY p.Category, c.Segment
)
SELECT * FROM ProfitByCategorySegment;

-- 3. Average Shipping Time by Region and Ship Mode

WITH AvgShipTime AS (
  SELECT 
    c.Region,
    o.[Ship Mode],
    AVG(DATEDIFF(DAY, o.[Order Date], o.[Ship Date])) AS AvgShipDays,
    COUNT(*) AS NumOrders
  FROM Orders o
  JOIN Customers c ON o.[Customer ID] = c.[Customer ID]
  GROUP BY c.Region, o.[Ship Mode]
)
SELECT * FROM AvgShipTime;

-- 4. Top Customers by Profit

WITH TopCustomers AS (
  SELECT 
    c.[Customer Name],
    c.Segment,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit,
    RANK() OVER (ORDER BY SUM(o.Profit) DESC) AS rn
  FROM Orders o
  JOIN Customers c ON o.[Customer ID] = c.[Customer ID]
  GROUP BY c.[Customer Name], c.Segment
)
SELECT * 
FROM TopCustomers
WHERE rn <= 10;

 -- 5. Low Profit Products (High Sales, Low or Negative Profit)

 WITH LowMarginProducts AS (
  SELECT 
    p.[Product Name],
    p.Category,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit,
    SUM(o.Profit)/NULLIF(SUM(o.Sales), 0) AS ProfitMargin
  FROM Orders o
  JOIN Products p ON o.[Product ID] = p.[Product ID]
  GROUP BY p.[Product Name], p.Category
)
SELECT * 
FROM LowMarginProducts
WHERE ProfitMargin < 0.05 -- or TotalProfit < 0
ORDER BY ProfitMargin ASC;

-- 6. Discount Effect by Sub-Category

WITH DiscountImpact AS (
  SELECT 
    p.[Sub-Category],
    AVG(o.Discount) AS AvgDiscount,
    AVG(o.Profit) AS AvgProfit,
    SUM(o.Sales) AS TotalSales
  FROM Orders o
  JOIN Products p ON o.[Product ID] = p.[Product ID]
  GROUP BY p.[Sub-Category]
)
SELECT * FROM DiscountImpact;


