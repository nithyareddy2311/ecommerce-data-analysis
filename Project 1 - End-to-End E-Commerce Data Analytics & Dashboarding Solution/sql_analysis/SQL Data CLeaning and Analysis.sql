CREATE DATABASE project_ecommerce;
USE project_ecommerce;
CREATE TABLE sales(
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
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Data Cleaning

SELECT DISTINCT Country
FROM sales;
SET SQL_SAFE_UPDATES = 0;
UPDATE sales
SET Country = 'United States'
WHERE (Country <> 'United States' OR Country IS NULL);
SELECT DISTINCT Country
FROM sales;

SELECT DISTINCT category
FROM sales;
SELECT DISTINCT ProductName 
FROM sales;


UPDATE sales
SET Category = 'Electronics'
WHERE ProductName IN (
'Drone Mini',
'Microphone',
'Power Bank 20000mAh',
'Webcam Full HD',
'Wireless Earbuds',
'Car Charger',
'Projector Mini',
'Graphic Tablet',
'Smartwatch',
'4K Monitor',
'Gaming Mouse',
'Memory Card 128GB',
'Portable SSD 1TB',
'Noise Cancelling Headphones',
'Router',
'USB-C Charger',
'Wireless Charger',
'HDMI Cable 2m',
'Action Camera',
'External HDD 2TB',
'Bluetooth Speaker',
'Mechanical Keyboard',
'Phone Tripod'
);

UPDATE sales
SET Category = 'Home & Kitchen'
WHERE ProductName IN (
'Cookware Set',
'Instant Pot',
'Air Fryer',
'Electric Kettle',
'Water Bottle',
'Desk Plant',
'LED Desk Lamp',
'Smart Light Bulb',
'Desk Organizer',
'Office Chair'
);

UPDATE sales
SET Category = 'Clothing'
WHERE ProductName IN (
'T-Shirt',
'Dress Shirt',
'Jeans',
'Running Shoes',
'Winter Jacket',
'Sunglasses'
);

UPDATE sales
SET Category = 'Toys & Games'
WHERE ProductName IN (
'Kids Toy Car',
'Puzzle 1000pc',
'Board Game'
);

UPDATE sales
SET Category = 'Sports & Outdoors'
WHERE ProductName IN (
'Yoga Mat',
'Backpack'
);

UPDATE sales
SET Category = 'Books'
WHERE ProductName IN (
'Novel Bestseller',
'Children''s Book'
);

UPDATE sales
SET Category = 'Electronics'
WHERE ProductName = 'Laptop Sleeve';

SELECT Category, GROUP_CONCAT(ProductName) AS Products
FROM sales
GROUP BY Category;



-- DATA EXPLORATION
SELECT COUNT(*) 
FROM sales;

SELECT *
FROM sales
LIMIT 10;

SELECT DISTINCT Category
FROM sales;

-- Revenue Analysis 
SELECT SUM(TotalAmount) AS Total_Revenue
FROM sales;

SELECT AVG(TotalAmount) AS Avg_Order_Value
FROM sales;

SELECT COUNT(OrderID) AS Total_Orders
FROM sales;

-- Category Performance
SELECT Category,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY Category
ORDER BY Revenue DESC;

SELECT Category,
SUM(Quantity) AS Total_Units
FROM sales
GROUP BY Category
ORDER BY Total_Units DESC;

-- Product Analysis

SELECT ProductName,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 10;

SELECT ProductName,
SUM(Quantity) AS Units_Sold
FROM sales
GROUP BY ProductName
ORDER BY Units_Sold DESC
LIMIT 10;

-- Brand Performance

SELECT Brand,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY Brand
ORDER BY Revenue DESC;

-- Customer Analysis 
SELECT CustomerName,
SUM(TotalAmount) AS Total_Spent
FROM sales
GROUP BY CustomerName
ORDER BY Total_Spent DESC
LIMIT 10;

-- Location Analysis
SELECT Country,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY Country
ORDER BY Revenue DESC;

SELECT City,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY City
ORDER BY Revenue DESC
LIMIT 10;

-- Payment Analysis

SELECT PaymentMethod,
COUNT(*) AS Orders
FROM sales
GROUP BY PaymentMethod
ORDER BY Orders DESC;

-- Order Status Analysis

SELECT OrderStatus,
COUNT(*) AS Total_Orders
FROM sales
GROUP BY OrderStatus;

-- Time Analysis

SELECT OrderYear,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY OrderYear;

SELECT OrderMonthName,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY OrderMonthName
ORDER BY Revenue DESC;

SELECT OrderQuarter,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY OrderQuarter;

-- Shipping Cost Analysis 

SELECT AVG(ShippingCost)
FROM sales;

-- Profit Insight

SELECT OrderID,
TotalAmount
FROM sales
ORDER BY TotalAmount DESC
LIMIT 10;

-- Advanced Analysis

SELECT OrderYear,
OrderMonth,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY OrderYear, OrderMonth
ORDER BY OrderYear, OrderMonth;

SELECT OrderYear,
Category,
SUM(TotalAmount) AS Revenue
FROM sales
GROUP BY OrderYear, Category
ORDER BY Revenue DESC;

SELECT Category,
SUM(TotalAmount) AS Revenue,
ROUND(SUM(TotalAmount) /
(SELECT SUM(TotalAmount) FROM ecommerce_sales) * 100,2) AS Revenue_Percentage
FROM sales
GROUP BY Category
ORDER BY Revenue DESC;


