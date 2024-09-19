-- 1. How many transactions are there
SELECT COUNT(*) FROM sales.transactions;

-- 2. Run a quick check of the tables to understand them and identify possible trash data 
SELECT * FROM markets; -- if you noticed, the last 2 lines are outside India so take them out, lets just focus on India
-- I need to know if all the transactions are based on INR 
SELECT currency, count(currency)FROM transactions
GROUP BY currency; 
-- Check if all sales amount are positive
SELECT * FROM transactions WHERE sales_amount>0;

-- Lets check transactions of a single market
SELECT * FROM sales.transactions LIMIT 5;
SELECT market_code, count(customer_code) FROM transactions
GROUP BY market_code; 
SELECT * FROM sales.transactions WHERE market_code = 'Mark001';
SELECT COUNT(*) FROM sales.transactions WHERE market_code = 'Mark001';

-- 3. Now, lets begin with a deeper analysis related to sales per year
-- Lets check the pandemic year transactions
SELECT * FROM sales.transactions WHERE YEAR(order_date) = 2020;

-- Lets check total sales of that year (2020)
SELECT SUM(sales_amount) FROM sales.transactions WHERE YEAR(order_date) = 2020;
-- try it with a JOIN
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date = sales.date.date WHERE sales.date.year = 2020;
SELECT*FROM date;

-- Lets check total sales of 2019
-- SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions;
SELECT SUM(sales_amount) FROM sales.transactions WHERE YEAR(order_date) = 2019;
-- Revenue decreased from 2019 to 2020
SELECT 
    SUM(CASE WHEN YEAR(order_date) = 2020 THEN sales_amount ELSE 0 END) AS total_sales_2020,
    SUM(CASE WHEN YEAR(order_date) = 2019 THEN sales_amount ELSE 0 END) AS total_sales_2019
FROM sales.transactions;



-- Now, let's see how Chenna (market Mark001) behaved in 2020
SELECT * FROM sales.markets;
SELECT SUM(sales_amount) FROM sales.transactions WHERE YEAR(order_date) = 2020 AND market_code = 'Mark001';


-- 4. Now tables are ready to create csv
SELECT * FROM sales.transactions WHERE sales_amount > 0;
SELECT * FROM sales.customers;
SELECT * FROM sales.markets WHERE zone != '';
SELECT * FROM sales.products;
SELECT * FROM sales.date;
SELECT * FROM sales.transactions;
