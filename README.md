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

# Quarterly KPI Visualization - README

This README provides instructions for creating Key Performance Indicators (KPIs) for Quarterly Revenue, Orders, and Profit using [YourTool]. The goal is to visualize the metrics and their targets for effective performance monitoring.

## Instructions

### Step 1: Create Quarterly Measures

1.1. Create the following measures for the Previous Quarter and Targets:
   - `Previous Quarter Profit`
   - `Previous Quarter Revenue`
   - `Previous Quarter Orders`
   - `Target Profit` (5% growth compared to the previous quarter)
   - `Target Revenue` (5% growth compared to the previous quarter)
   - `Target Orders` (5% growth compared to the previous quarter)

### Step 2: Add Revenue KPI

2.1. Create a new KPI for Revenue:

   - **Value Field:** Total Revenue
   - **Trend Axis:** Start of Quarter
   - **Target:** Target Revenue

2.2. In the Format Pane:
   - Set Trend Axis to On.
   - Expand the associated tab and set the following values:
      - **Direction:** High is Good
      - **Bad Colour:** Red
      - **Transparency:** 15%

2.3. Format the Callout Value to show only 1 decimal place.

### Step 3: Duplicate Cards for Profit and Orders

3.1. Duplicate the Revenue KPI card two more times.

3.2. For the duplicated cards:
   - Set the Value Field to `Total Profit` for the Profit card.
   - Set the Value Field to `Total Orders` for the Orders card.
   - Ensure Trend Axis and Target values are appropriately updated.

### Step 4: Arrange Cards

4.1. Arrange the three cards (Revenue, Profit, Orders) below the Revenue line chart for a comprehensive view.

### Step 5: Review and Share

5.1. Review the visualization to ensure accurate representation and adherence to business goals.

5.2. Share the [YourTool] report or dashboard with relevant stakeholders.

## Notes

- Adjust placeholders like [YourTool] and [YourDataset] with your actual tool and dataset names.
- Refer to [YourTool] documentation for specific instructions on creating measures, KPIs, and formatting options.

Happy visualizing!

# Power BI Report README

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Instructions](#instructions)
  - [Adding a Button](#adding-a-button)
  - [Creating a Rectangle Shape](#creating-a-rectangle-shape)
  - [Adding Slicers](#adding-slicers)
  - [Configuring Slicers](#configuring-slicers)
  - [Setting Tooltip for the Button](#setting-tooltip-for-the-button)
  - [Creating Bookmarks](#creating-bookmarks)
- [Notes](#notes)
- [License](#license)

## Introduction
This Power BI report is designed to include a customized navigation bar, slicers, and a slicer toolbar with specific functionalities. It provides a user-friendly interface for interacting with data.

## Features
- Customized navigation bar with buttons.
- Rectangle shape serving as a slicer toolbar.
- Slicers for filtering data by "Product Category" and "Country."
- Bookmarks for toggling the visibility of the slicer toolbar.

## Instructions

### Adding a Button
1. Go to the "Home" tab.
2. Click on the "Button" control to add a blank button to the report canvas.
3. Customize the button properties, set the icon type to "Custom," and choose "Filter_icon.png" as the icon image.
4. Set the tooltip text to "Open Slicer Panel."

### Creating a Rectangle Shape
1. Add a rectangle shape from the "Home" tab.
2. Customize the rectangle's dimensions and color to match the navigation bar.
3. Bring the rectangle to the top of the stacking order in the Selection pane.

### Adding Slicers
1. Drag "Products[Category]" and "Stores[Country]" fields into the report canvas.
2. Rename slicers to "Product Category" and "Country" in the "Visualizations" pane.
3. Set slicer style to "Vertical List."

### Configuring Slicers
1. Configure "Product Category" slicer to allow multiple selections.
2. Configure "Country" slicer for single selection and enable the "Select All" option.

### Setting Tooltip for the Button
1. Select the button.
2. Open the Format pane and set the tooltip text to "Open Slicer Panel."

### Creating Bookmarks
1. Open the Bookmarks pane from the "View" tab.
2. Add two new bookmarks: "Slicer Bar Closed" and "Slicer Bar Open."
3. Hide/Show the toolbar group in the Selection pane for each bookmark.
4. Right-click on each bookmark and ensure that "Data" is unchecked.

## Notes
- Make sure to save your work regularly.
- Test the functionality of buttons, slicers, and bookmarks to ensure they work as expected.

### Creating a Custom Tooltip Page
1. Create a new blank page in Power BI.
2. Add the Profit Gauge visual to this new page.
3. Return to the original page with the map visual.
4. Select the map visual.
5. In the Visualizations pane, drag the new custom tooltip page into the "Tooltip" field well.
6. Adjust the formatting and appearance of the tooltip in the Format pane.

Interactions Configuration
Executive Summary Page
Product Category Bar Chart and Top 10 Products Table: These visuals will not filter the card visuals or KPIs.
Customer Detail Page
Top 20 Customers Table: Will not filter any other visuals.
Total Customers by Product Donut Chart: Will not affect the Customers Line Graph.
Total Customers by Country Donut Chart: Cross-filters the Total Customers by Product Donut Chart.
Product Detail Page
Orders vs. Profitability Scatter Graph: Does not affect any other visuals.
Top 10 Products Table: Does not affect any other visuals.
Navigation Buttons
Executive Summary Page
In the sidebar of the Executive Summary page, four new blank buttons have been added.

Button 1 (Icon: ExecutiveSummaryWhite.png):

Default Appearance: White
Hover Appearance: Cyan
Action: Page navigation to Executive Summary Page
Button 2 (Icon: CustomerDetailWhite.png):

Default Appearance: White
Hover Appearance: Cyan
Action: Page navigation to Customer Detail Page
Button 3 (Icon: ProductDetailWhite.png):

Default Appearance: White
Hover Appearance: Cyan
Action: Page navigation to Product Detail Page
Button 4 (Icon: HomeWhite.png):

Default Appearance: White
Hover Appearance: Cyan
Action: Page navigation to Home or main landing page
Customer Detail Page
Buttons are identical in appearance to the Executive Summary Page.

Product Detail Page
Buttons are identical in appearance to the Executive Summary Page.

How to Use
Open the Power BI report.
Navigate between pages using the custom navigation buttons in the sidebar.
Explore the visuals on each page, keeping in mind the defined interactions for a seamless and focused analysis.
Additional Notes



