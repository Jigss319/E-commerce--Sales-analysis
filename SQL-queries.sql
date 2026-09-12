# E-commerce Sales Analysis
# SQL Queries Used for Business Analysis

# Q1. Calculate the total revenue generated from all completed sales
# This helps the business understand its overall sales revenue

SELECT 
     SUM(o_i.quantity*p.price) AS total_revenue
     FROM order_items AS o_i
     JOIN products AS p
     ON o_i.product_id= p.product_id

# Q2. Identify the top 5 customers based on their total spending
# This helps the business understand which customers generate the most revenue.

SELECT c.customer_name,c.customer_id,
                         COUNT(DISTINCT o.order_id) AS total_order_items,
                         SUM(o_i.quantity*p.price) AS total_spending
                         FROM customers AS c
                         JOIN orders AS o
                         USING(customer_id)
                         JOIN order_items AS o_i
                         USING(order_id)
                         JOIN products AS p
                         USING(product_id) 
                         GROUP BY c.customer_id, c.customer_name
                         ORDER BY total_spending DESC
                         LIMIT 5

                                             
# Q3. Analyze each customers total number of orders and total spending
# This helps the business identify customer purchasing behavior and high-value customers.

SELECT c.customer_id,c.customer_name,
                         COUNT(DISTINCT o.order_id) AS total_order,
                         SUM(o_i.quantity * p.price) AS total_spending
                         FROM customers AS c
                         JOIN orders AS o
                         ON c.customer_id = o.customer_id
                         JOIN order_items AS o_i
                         ON o.order_id = o_i.order_id
                         JOIN products AS P
                         ON o_i.product_id = p.product_id
                         GROUP BY c.customer_id,c.customer_name ;

# Q4. Calculate the total spending of each customer
# This helps the business identify customers who contribute the most revenue.

SELECT c.customer_id,c.customer_name,
                                SUM(o_i.quantity*p.price) AS total_spending
                                FROM customers AS c
                                JOIN orders AS o
                                ON c.customer_id = o.customer_id
                                JOIN order_items AS o_i
                                ON o.order_id = o_i.order_id
                                JOIN products AS p
                                ON o_i.product_id = p.product_id
                                GROUP BY c.customer_id,c.customer_name
                                ORDER BY total_spending DESC
                                LIMIT 5

# Q5. Identify the top 5 best-selling products based on total quantity sold
# This helps the business understand which products have the highest demand.

SELECT p.product_id,p.product_name,SUM(o_i.quantity) AS total_quantity_sold
                          FROM products AS p
                          JOIN order_items AS o_i
                          ON p.product_id = o_i.product_id
                          GROUP BY p.product_id,p.product_name 
                          ORDER BY total_quantity_sold DESC
                          LIMIT 5

#Q6. Segement customers based on their total spending 
# This helps the business identify high-value,mid-value,and low-value customers.

SELECT c.customer_id,c.customer_name,
                                SUM(o_i.quantity*p.price) AS total_spending,
                                 CASE
                                  WHEN SUM(o_i.quantity*p.price) > 50000 THEN 'High-Value Customer'
                                  WHEN SUM(o_i.quantity*p.price) > 20000 THEN 'Mid-Value Customer'
                                  ELSE 'Low-Value Customer'
                                 END AS customer_segement
                                FROM customers AS c
                                JOIN orders AS o
                                ON c.customer_id=o.customer_id
                                JOIN order_items AS o_i
                                ON o.order_id = o_i.order_id
                                JOIN products AS p
                                ON o_i.product_id = p.product_id
                                GROUP BY c.customer_id,c.customer_name
                                ORDER BY
                                 CASE customer_segement
                                  WHEN 'Low-Value Customer'THEN 1
                                  WHEN 'Mid-Value Customer'THEN 2
                                  WHEN 'High-Value Customer' THEN 3
                                 END DESC

