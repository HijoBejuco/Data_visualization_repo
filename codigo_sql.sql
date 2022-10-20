/* -------------------------------------- IMPORT CSV FILE --------------------------------------------*/
-- Create empty table with the same structure as the superstore table
CREATE TABLE superstore 
(
    Row_ID BIGSERIAL NOT NULL PRIMARY KEY, 
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer VARCHAR(50),
    Customer_Name VARCHAR(50),
    Segment VARCHAR(20),
    Country VARCHAR(20),
    City VARCHAR(20),
    Statee VARCHAR(20),
    Postal_Code INTEGER,
    Region VARCHAR(10),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name TEXT,
    Sales FLOAT,
    Quantity INTEGER, 
    Discount FLOAT, 
    Profit FLOAT
);

/* -------------------------------- IMPORT CSV FILE ----------------------------------------*/
COPY superstore FROM 'e:/Desktop/Nueva_carpeta/Bosques/Programming_courses/Principios_de_visualicacion_de_Datos_para_Bussiness_Inteligence/superstore.csv' DELIMITER ';' CSV HEADER;


/* --------------------------------- EXPORT CSV FILE ----------------------------------------*/
--The next code is to export the complete superstore dataset into csv file. 

COPY (SELECT * FROM superstore) TO 'e:/Desktop/Nueva_carpeta/Bosques/Programming_courses/Principios_de_visualicacion_de_Datos_para_Bussiness_Inteligence/superstore.csv' CSV HEADER;

------------------------------- FIRST QUESTION (QUERY) ----------------------------------------
--The following code returns the sum of all profits generated each year and 
--the total quantity of sold articles per year.
SELECT EXTRACT(YEAR FROM Order_Date) AS year, SUM(Profit) AS Profit, SUM(Quantity) AS Quantity
FROM superstore GROUP BY year ORDER BY profit ASC;

------------------------------- SECOND QUESTION (QUERY) ----------------------------------------
SELECT Customer_Name, SUM(Profit) AS Profit, Segment FROM superstore 
GROUP BY Customer_Name, Segment 
ORDER BY Profit DESC LIMIT 10;

------------------------------- THIRD QUESTION (QUERY) -------------------------------------
    
SELECT Statee AS State, SUM(Profit) As Profit FROM superstore
GROUP BY State ORDER BY Profit DESC;

------------------------------- FOURTH QUESTION (QUERY) -------------------------------------

SELECT Region, SUM(Profit) As Profit FROM superstore
GROUP BY Region ORDER BY Profit DESC;

------------------------------- FIFTH QUESTION (QUERY) -------------------------------------
--the following query uses the function EXTRACT to concat two columns and generate the 
--'year_month' column, which will work as the x axis in the scatter plot. 

SELECT EXTRACT(YEAR FROM Order_Date) AS year, EXTRACT(MONTH FROM Order_Date) AS month
, CONCAT(EXTRACT(YEAR FROM Order_Date), EXTRACT(MONTH FROM Order_Date)) AS year_month, 
SUM(Profit) AS profit, SUM(Quantity) AS quantity 
FROM superstore GROUP BY year, month ORDER BY year, month;