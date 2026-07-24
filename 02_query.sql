SELECT * FROM customers;
select * from order_items;
select * from order_payments;
select * from orders;
select * from products;


SELECT
    payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS average_payment
FROM order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

SELECT
order_status,
COUNT(*)
FROM orders
GROUP BY order_status;

SELECT customer_state, COUNT(customer_state) AS total_states
from customers
group by customer_state