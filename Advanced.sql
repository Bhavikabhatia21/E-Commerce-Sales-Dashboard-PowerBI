SELECT * FROM orders;

SELECT order_status ,COUNT(*) as total_orders
from orders
group by order_status


SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END) AS cancelled_orders,
    ROUND(
        SUM(CASE
                WHEN order_status = 'canceled' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM orders;

SELECT
AVG(order_delivered_customer_date - order_purchase_timestamp)
AS average_delivery_time
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


SELECT
    order_id,
    order_delivered_customer_date::date - order_purchase_timestamp::date AS delivery_days,
    CASE
        WHEN order_delivered_customer_date::date - order_purchase_timestamp::date <= 2 THEN 'Fast'
        WHEN order_delivered_customer_date::date - order_purchase_timestamp::date <= 5 THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



select * from order_items;

WITH seller_revenue AS (
    SELECT 
        seller_id,
        SUM(price) AS total_revenue
    FROM order_items
    GROUP BY seller_id
)
SELECT 
    seller_id,
    total_revenue
FROM seller_revenue
WHERE total_revenue > 50000
ORDER BY total_revenue DESC;


SELECT
    seller_id,
    SUM(price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(price) DESC) AS seller_rank
FROM order_items
GROUP BY seller_id;

SELECT
    seller_id,
    SUM(price) AS total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS seller_rank
FROM order_items
GROUP BY seller_id;

SELECT
    seller_id,
    SUM(price) AS total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(price) DESC) AS row_num
FROM order_items
GROUP BY seller_id;

WITH seller_revenue AS
(
    SELECT
        seller_id,
        SUM(price) AS total_revenue,
        DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS seller_rank
    FROM order_items
    GROUP BY seller_id
)

SELECT *
FROM seller_revenue
WHERE seller_rank <= 3;