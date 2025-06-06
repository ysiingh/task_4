CREATE DATABASE IF NOT EXISTS olist;
USE olist;

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer_state VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price FLOAT,
    freight_value FLOAT
);
TRUNCATE TABLE customers;

SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW TABLES;

SELECT customer_state, COUNT(*) AS order_count
FROM customers
GROUP BY customer_state
ORDER BY order_count DESC;

SELECT order_id, product_id, price
FROM order_items
ORDER BY price DESC
LIMIT 5;

SELECT AVG(freight_value) AS avg_freight, MAX(price) AS max_price
FROM order_items;

CREATE VIEW high_priced_items AS
SELECT order_id, product_id, price
FROM order_items
WHERE price > 300;

SELECT product_id, AVG(price) AS avg_price
FROM order_items
GROUP BY product_id
ORDER BY avg_price DESC
LIMIT 5;
