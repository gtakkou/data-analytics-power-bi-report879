# Table of Contents
1. [Introduction](#introduction)
2. [Import and Cleaning](#Import and Cleaning)
    - [Import](#Import)
    - [Cleaning](#Cleaning)


## Introduction
We have recently been approached by a medium-sized international retailer who is keen on elevating their business intelligence practices. With operations spanning across different regions, they've accumulated large amounts of sales from disparate sources over the years
and we are responsible to analyse their data to help them with decision making of the company to increase sales

## Import and Cleaning
The first phase of the project involves data loading and preparation. We have connected with Azure SQL Database, Miscrofft Azure storage account
and web-hosted CSV files in order to import the necessary components of the dataset. Once imported we have cleaned and organized the data by removing
irrelevant columns, splitting data-time details and ensuring the data consistency

### Import
1. We have imported the Orders table by connecting to the Azure SQL Database and importing the orders_powerbi table using the impornt in Power BI.
   For this funciton we need the server name, database name, username and password.
2. We have imported the Products table by the Get Data option by importing a csv file.
3. We have imported the Stores Table by using Blob storage Credentials by connecting to Azure Blob Storage. For this connection we needed an account_name, Account)Key and
   Container Name.
4. Lastly we have imported the Customers Table by downloading the customers.zip file and unzipping it and then through the Get Data Option we imported it in the Power BI.

### Cleaning
1. Navigate to the Power Query Editor and delete the column named [Card Number] to ensure data privacy
   Use the Split Column feature to separate the [Order Date] and [Shipping Date] columns into two distinct columns each: one for the date and another for the timeFilter out and remove any rows where the [Order Date] column has missing or null values to maintain data integrity
   Rename the columns in your dataset to align with Power BI naming conventions, ensuring consistency and clarity in your report

2. In Power Query Editor, use the Column From Examples feature to generate two new columns from the weight column - one for the weight values and another for the units (e.g. kg, g, ml). You might need to sort the weight column by descending to get enough different examples to work with.
   For the newly created units column, replace any blank entries with kg
   For the values column, convert the data type to a decimal number
   If any errors arise during the conversion, replace those error values with the number 1
   From the Data view, create a new calculated column, such that if the unit in the units column is not kg, divide the corresponding value in the values column by 1000 to convert it to kilograms
   Return to the Power Query Editor and delete any columns that are no longer needed


### Date Table Generation

To create the date table, I used the following DAX formula in Power BI:

```DAX
DateTable = CALENDAR(MIN('Orders'[Order Date]), MAX('Orders'[Shipping Date]))

### Power BI Data Model

![Power BI Data Model](![Uploading image.png…]()
)

### Key Measures and Calculated Columns

- **Total Revenue:**
  ```DAX
  Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale_Price]))

Total Profit = SUMX(Orders, (RELATED(Products[Sale_Price]) - RELATED(Products[Cost_Price])) * Orders[Product Quantity])

Total Customers = COUNTROWS(VALUES(Orders[CustomerID]))

Total Quantity = SUM(Orders[Product Quantity])

Revenue YTD = CALCULATE(SUMX(FILTER(ALL('Date'), 'Date'[Year] = YEAR(TODAY())), Orders[Product Quantity] * RELATED(Products[Sale_Price])))

Profit YTD = CALCULATE(SUMX(FILTER(ALL('Date'), 'Date'[Year] = YEAR(TODAY())), (RELATED(Products[Sale_Price]) - RELATED(Products[Cost_Price])) * Orders[Product Quantity]))

## Report Pages

The project includes the following report pages:
1. **Executive Summary:** Overview of key metrics and visualizations.
2. **Customer Detail:** Detailed insights into customer behavior.
3. **Product Detail:** Analysis of product sales and performance.
4. **Stores Map:** Geographical representation of sales.

## Visualizations

The visualizations in this project include:
- **Line Chart:** Showing trends in total customers over time.
- **Donut Chart:** Displaying the distribution of customers by country.
- **Column Chart:** Illustrating the number of customers per product category.



