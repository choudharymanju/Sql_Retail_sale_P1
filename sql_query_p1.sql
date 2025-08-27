--Create Table
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

select count(*)  from public.retail_sales_tb;

--- Data Cleaning
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

---
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

--Data Exploration

1--How Many sales we have?
Select count(*) from public.retail_sales_tb;

2--How many unique customers we have?
select count(distinct customer_id)from public.retail_sales_tb;

3-- How many category we have?
Select distinct category from public.retail_sales_tb;

4--Data analysis & Business key Problems & answers write a sql query to retrieve all column for sales made on '2022-11-05'
select * from public.retail_sales_tb
where sale_date ='2022-11-05'

5--Write a sql query to retrieve all transactions where the category is clothing and the quantity sold is more then 4 in the month of Nov 2022.
SELECT *
FROM public.retail_sales_tb
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date <= '2022-11-30'
  AND quantiy >= 4;
  
6---write a sql query to calculate the total sales (total_sale) for each category?
Select 
category,
sum(total_sale) as Total_sales
from public.retail_sales_tb
group by 1;

7--write a sql query to find the average age of customers who purchased items from the 'beauty' category.
SELECT
ROUND(AVG(age),2)AS avage
FROM public.retail_sales_tb
WHERE category = 'Beauty'

8---Write a sql query to find all transactions where the total_sale is greater then 1000.
select * FROM public.retail_sales_tb
where total_sale>1000

9--- write a sql query to find the total nummbers of txn(Tranasaction_id) made by each gendar in each category.
Select 
category,
gender,
count(*)as total_txn
from public.retail_sales_tb
group by
1,2
order by 1;
10-- write a sql query to calculate the averge sale for each month,find out best selling month in each year.
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

10--write sql query to find the top 5 customer based on the higest total sales. 
select customer_id,
sum(total_sale) as total_sales
from public.retail_sales_tb
group by 1
order by 2 desc
limit 5;

11---write a sql query to find the number of unique customers who purchased items from each catgory.
select 
category,
count(distinct customer_id) as unique_customer
from public.retail_sales_tb
group by 1; 

12--write a sql query to create each shift and number of orders(exm=morning<=12,afternoon between 12&17,evening >17)
with Hourly_sale
as
(select *,
CASE 
when extract (HOUR FROM sale_time)<12 then 'Morning'
when extract (HOUR FROM sale_time)Between 12 and 17 then 'Afternoon'
else 'evening'
END AS shift
from public.retail_sales_tb)
select 
shift,
count(*) as total_sales
from Hourly_sale
group by shift

---End Of Project



