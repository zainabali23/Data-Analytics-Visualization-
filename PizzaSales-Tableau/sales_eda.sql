DBCC FREEPROCCACHE

SELECT *
FROM PizzaSales

--------------------------------------------------------------------------------------------------------------------------

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM PizzaSales

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM PizzaSales

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM PizzaSales

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS decimal(10,2)) / CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) AS Avg_Pizzas_Per_Order
FROM PizzaSales

--------------------------------------------------------------------------------------------------------------------------

-- Daily Trend for Total Orders
SELECT
	DATENAME(DW, order_date) AS Order_Day,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC

-- Monthly Trend for Total Orders
SELECT
	DATENAME(MONTH, order_date) AS Order_Month,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

--------------------------------------------------------------------------------------------------------------------------

-- % of Sales by Pizza Category
SELECT 
	pizza_category,
	CAST(SUM(total_price) AS decimal(10,2)) AS Total_Revenue,
	CAST(SUM(total_price)*100 / (SELECT SUM(total_price) FROM PizzaSales) AS decimal(10,2)) AS Percent_Sales
FROM PizzaSales
GROUP BY pizza_category
ORDER BY Percent_Sales DESC

-- % of Sales by Pizza Size
SELECT 
	pizza_size,
	CAST(SUM(total_price) AS decimal(10,2)) AS Total_Revenue,
	CAST(SUM(total_price)*100 / (SELECT SUM(total_price) FROM PizzaSales) AS decimal(10,2)) AS Percent_Sales
FROM PizzaSales
GROUP BY pizza_size
ORDER BY Percent_Sales DESC

--------------------------------------------------------------------------------------------------------------------------

-- Total Pizzas Sold by Pizza Category in February
SELECT
	pizza_category,
	SUM(quantity) AS Total_Pizzas_Sold
FROM PizzaSales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC

--------------------------------------------------------------------------------------------------------------------------

-- Top 5 Pizzas by Revenue
SELECT TOP 5
	pizza_name,
	SUM(total_price) AS Total_Revenue
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 Pizzas by Revenue
SELECT TOP 5
	pizza_name,
	SUM(total_price) AS Total_Revenue
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--------------------------------------------------------------------------------------------------------------------------

-- Top 5 Pizzas by Total Quantity
SELECT TOP 5
	pizza_name,
	SUM(quantity) AS Total_Pizzas_Sold
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC

-- Bottom 5 Pizzas by Total Quantity
SELECT TOP 5
	pizza_name,
	SUM(quantity) AS Total_Pizzas_Sold
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC

--------------------------------------------------------------------------------------------------------------------------

-- Top 5 Pizzas by Total Orders
SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Bottom 5 Pizzas by Total Orders
SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Orders ASC