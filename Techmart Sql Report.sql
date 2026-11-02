use Techmart;
select*from techmart_sales;

#1. Find the total sales, total profit, and total quantity sold.
create view 
		total_sales as 
  select 
        sum(sales) as total_sales
   from techmart_sales;
create view
		total_profit as 
  select 
        sum(profit) as total_profit 
  from techmart_sales;
create view
           total_quantity as 
  select 
        sum(quantity) as total_quantity
  from techmart_sales;

#2. Find total sales and profit by region.
create view 
      total_sales_profit_by_region as
      
  select
       region , 
       sum(profit) as total_profit ,
       sum(sales) as total_sales 
  from techmart_sales 
  group by region ; 

#3. Find total sales and profit by product category.
create view
       total_sales_profit_by_category as 
  select 
      category , 
      sum(profit) as total_profit ,
      sum(sales) as total_sales
  from techmart_sales 
  group by category ; 

#4. Find the top 10 products by total sales.
 create view 
        top10_products_by_total_sales as
  select 
      product,
      sum(sales) as total_sales 
  from techmart_sales 
  group by product 
  order by total_sales 
  desc limit 10  ;

#5. Find the top 10 customers by total spending.
create view 
       top10_customers_by_total_spending as
  select 
       customer_name,
       sum(sales) as total_spending
  from techmart_sales 
  group by customer_name 
  order by total_spending 
  desc limit 10  ;

#6. Find the top 5 salespersons by total sales.
create view
         top5_salespersons_by_total_sales as 
  select
      salesperson, 
      sum(sales) as total_sales
  from techmart_sales
  group by salesperson
  order by total_sales
  desc limit 5  ;

#6. Find customers who have placed more than 5 orders.
create view 
        top5_customers as 
  select 
       customer_name , 
       count(order_id) as total_orders
  from techmart_sales 
  group by customer_name 
  having total_orders>5;
  
  
#7. Find products that have high sales but low profit.
SELECT
    Product,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM techmart_sales
GROUP BY Product
HAVING SUM(Sales) > 
       (SELECT AVG(Product_Sales)
        FROM
        (
            SELECT SUM(Sales) AS Product_Sales
            FROM techmart_sales
            GROUP BY Product
        ) AS x)
AND SUM(Profit) <
       (SELECT AVG(Product_Profit)
        FROM
        (
            SELECT SUM(Profit) AS Product_Profit
            FROM techmart_sales
            GROUP BY Product
        ) AS y);