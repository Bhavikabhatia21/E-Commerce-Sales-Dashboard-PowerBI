select * from customers;

select * from orders;

select * from order_items;

select * from order_payments;

select * from products;

select customer_state,COUNT(o.order_id)
as total_order
from customers c
INNER JOIN orders as o
on c.customer_id = o.customer_id
group by customer_state
order by total_order DESC;


select customer_city,COUNT(c.customer_id)
as total_customers 
from customers c
GROUP BY 
    customer_city
ORDER BY 
    total_customers  DESC
LIMIT 10;

select * from orders;

select customer_id,COUNT(o.order_id)
as total_orders
from orders o
group by customer_id
ORDER BY 
    total_orders  DESC
LIMIT 10

select * from products;
select * from order_payments;
select * from order_items;
select * from orders;
select * from customers;



SELECT p.product_id,
       SUM(o.price) AS total_revenue
FROM products AS p
INNER JOIN order_items AS o
ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC
LIMIT 10;

select c.customer_id,SUM(p.payment_value) 
as total_revenue
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
inner join order_payments as p
on o.order_id = p.order_id
group by c.customer_id
order by total_revenue DESC
LIMIT 10;

select * from order_items;

select p.product_category_name,SUM(o.price)
as total_revenue
from products as p
inner join order_items as o
on p.product_id = o.product_id
group by p.product_category_name
order by total_revenue DESC
LIMIT 10;

select seller_id ,SUM(price)
as total_revenue
from order_items
group by seller_id
order by total_revenue DESC
LIMIT 10;

select * from order_payments;
select * from orders;


SELECT 
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,
    SUM(op.payment_value) AS total_revenue
FROM orders AS o
INNER JOIN order_payments AS op
ON o.order_id = op.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
ORDER BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM');


SELECT 
 TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,
    COUNT(o.order_id) AS total_orders
	from orders as o
	GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
	ORDER BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM');
	
