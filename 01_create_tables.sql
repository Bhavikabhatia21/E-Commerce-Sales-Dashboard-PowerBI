CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);
COPY customers(customer_id,customer_unique_id,customer_zip_code_prefix,customer_city,customer_state)
FROM 'E:\\archive\\olist_customers_dataset.csv'
DELIMITER ',' 
CSV HEADER;


select * from customers

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

COPY orders(order_id,customer_id,order_status,order_purchase_timestamp,order_approved_at,order_delivered_carrier_date,
order_delivered_customer_date,order_estimated_delivery_date)
FROM 'E:\\archive\\olist_orders_dataset.csv'
DELIMITER ',' 
CSV HEADER;

select * from orders


CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(20),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

COPY order_payments(order_id,payment_sequential,
    payment_type,payment_installments,payment_value)
FROM 'E:\\archive\\olist_order_payments_dataset.csv'
DELIMITER ',' 
CSV HEADER;

select * from order_payments


CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2),
    PRIMARY KEY (order_id, order_item_id)
);

COPY order_items(order_id,order_item_id,product_id,
    seller_id,
    shipping_limit_date ,
    price,
    freight_value )
FROM 'E:\\archive\\olist_order_items_dataset.csv'
DELIMITER ',' 
CSV HEADER;


CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

COPY products(product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght ,
    product_photos_qty ,
    product_weight_g ,
    product_length_cm ,
    product_height_cm,
    product_width_cm)
FROM 'E:\\archive\\olist_products_dataset.csv'
DELIMITER ',' 
CSV HEADER;


ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_payments;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;


SELECT ROUND(SUM(payment_value), 2) AS total_revenue
FROM order_payments;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT ROUND(AVG(payment_value), 2) AS average_order_value
FROM order_payments;