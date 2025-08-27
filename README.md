# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_Project_P1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_Project_P1`.
- **Table Creation**: A table named `Retail_sales_Tb` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_Project_P1;

CREATE TABLE Retail_sales_Tb (
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR (15),
age INT,
category VARCHAR (15),
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
)
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
Select count(*) from public.retail_sales_tb;
select count(distinct customer_id)from public.retail_sales_tb;
Select distinct category from public.retail_sales_tb;

Select * from public.retail_sales_tb
where 
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

Delete from public.retail_sales_tb
where 
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05':
```sql
select *
from public.retail_sales_tb
where sale_date ='2022-11-05'
```

2. *Write a SQL query to retrieve all transactions where the category is clothing and the quantity sold is more than 4 in the month of November 2022**:
```sql
SELECT *
FROM public.retail_sales_tb
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date <= '2022-11-30'
  AND quantiy >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
Select 
category,
sum(total_sale) as Total_sales
from public.retail_sales_tb
group by 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
ROUND(AVG(age),2)AS avage
FROM public.retail_sales_tb
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * FROM public.retail_sales_tb
where total_sale>1000
```

6. **Write a SQL query to find the total number of txn(Tranasaction_id) made by each gender in each category.**:
```sql
Select 
category,
gender,
count(*)as total_txn
from public.retail_sales_tb
group by
1,2
order by 1;
```

7. **write a sql query to calculate the average sale for each month, find out best selling month in each year**:
```sql
select
year,
month,
avg_sale
from
(Select 
EXTRACT (YEAR from sale_date) as Year,
EXTRACT (Month from sale_date) as Month,
avg(total_sale) as avg_sale,
RANK()OVER (PARTITION BY EXTRACT(YEAR from sale_date) ORDER BY avg(total_sale)DESC) AS Rank
FROM public.retail_sales_tb
group by 1,2) as T1
where rank=1
```
8. **Write SQL query to find the top 5 customers based on the highest total sales **:
```sql
select customer_id,
sum(total_sale) as total_sales
from public.retail_sales_tb
group by 1
order by 2 desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
category,
count(distinct customer_id) as unique_customer
from public.retail_sales_tb
group by 1;
```

10. **Write a SQL query to create each shift and number of orders(e.g., morning <=12, afternoon between 12&17, evening >17)**:
```sql
with Hourly_sale
as
(select *,
CASE 
when extract (HOUR FROM sale_time)<12 then 'Morning'
When extract (HOUR FROM sale_time)Between 12 and 17 then 'Afternoon'
else 'evening'
END AS shift
from public.retail_sales_tb)
select 
shift,
count(*) as total_sales
from Hourly_sale
group by shift
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Zero Analyst

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/manju-choudhary)

Thank you for your support, and I look forward to connecting with you!

