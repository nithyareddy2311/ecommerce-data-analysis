CREATE DATABASE ecommerce_project;
USE ecommerce_project;
CREATE TABLE ecommerce_sales(
OrderID VARCHAR(20),
OrderDate DATE,
CustomerID VARCHAR(20),
CustomerName VARCHAR(100),
ProductID VARCHAR(20),
ProductName VARCHAR(100),
Category VARCHAR(50),
Brand VARCHAR(50),
Quantity INT,
UnitPrice FLOAT,
Discount FLOAT,
Tax FLOAT,
ShippingCost FLOAT,
TotalAmount FLOAT,
PaymentMethod VARCHAR(50),
OrderStatus VARCHAR(50),
City VARCHAR(50),
State VARCHAR(50),
Country VARCHAR(50),
SellerID VARCHAR(20),
OrderYear INT,
OrderMonth INT,
OrderMonthName VARCHAR(20),
OrderQuarter VARCHAR(10),
OrderWeekday VARCHAR(20),
OrderDay INT,
OrderStatusCategory VARCHAR(20)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_Salesdata.csv'
INTO TABLE ecommerce_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM ecommerce_sales;
-- DATA EXPLORATION
SELECT COUNT(*) 
FROM ecommerce_sales;

SELECT *
FROM ecommerce_sales
LIMIT 10;

SELECT DISTINCT Category
FROM ecommerce_sales;

-- Revenue Analysis 
SELECT SUM(TotalAmount) AS Total_Revenue
FROM ecommerce_sales;

SELECT AVG(TotalAmount) AS Avg_Order_Value
FROM ecommerce_sales;

SELECT COUNT(OrderID) AS Total_Orders
FROM ecommerce_sales;

-- Category Performance
SELECT Category,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY Category
ORDER BY Revenue DESC;

SELECT Category,
SUM(Quantity) AS Total_Units
FROM ecommerce_sales
GROUP BY Category
ORDER BY Total_Units DESC;

-- Product Analysis

SELECT ProductName,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 10;

SELECT ProductName,
SUM(Quantity) AS Units_Sold
FROM ecommerce_sales
GROUP BY ProductName
ORDER BY Units_Sold DESC
LIMIT 10;

-- Brand Performance

SELECT Brand,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY Brand
ORDER BY Revenue DESC;

-- Customer Analysis 
SELECT CustomerName,
SUM(TotalAmount) AS Total_Spent
FROM ecommerce_sales
GROUP BY CustomerName
ORDER BY Total_Spent DESC
LIMIT 10;

-- Location Analysis
SELECT Country,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY Country
ORDER BY Revenue DESC;

SELECT City,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY City
ORDER BY Revenue DESC
LIMIT 10;

-- Payment Analysis

SELECT PaymentMethod,
COUNT(*) AS Orders
FROM ecommerce_sales
GROUP BY PaymentMethod
ORDER BY Orders DESC;

-- Order Status Analysis

SELECT OrderStatus,
COUNT(*) AS Total_Orders
FROM ecommerce_sales
GROUP BY OrderStatus;

-- Time Analysis

SELECT OrderYear,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY OrderYear;

SELECT OrderMonthName,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY OrderMonthName
ORDER BY Revenue DESC;

SELECT OrderQuarter,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY OrderQuarter;

-- Shipping Cost Analysis 

SELECT AVG(ShippingCost)
FROM ecommerce_sales;

-- Profit Insight

SELECT OrderID,
TotalAmount
FROM ecommerce_sales
ORDER BY TotalAmount DESC
LIMIT 10;

-- Advanced Analysis

SELECT OrderYear,
OrderMonth,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY OrderYear, OrderMonth
ORDER BY OrderYear, OrderMonth;

SELECT OrderYear,
Category,
SUM(TotalAmount) AS Revenue
FROM ecommerce_sales
GROUP BY OrderYear, Category
ORDER BY Revenue DESC;

SELECT Category,
SUM(TotalAmount) AS Revenue,
ROUND(SUM(TotalAmount) /
(SELECT SUM(TotalAmount) FROM ecommerce_sales) * 100,2) AS Revenue_Percentage
FROM ecommerce_sales
GROUP BY Category
ORDER BY Revenue DESC;


