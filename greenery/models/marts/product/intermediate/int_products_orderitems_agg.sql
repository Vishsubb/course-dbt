{{config(
    materialized = 'table'
)
}}

with orders as (
    select * from {{ref('stg_postgres_orders')}}
)

, order_items as (
    select * from {{ref('stg_postgres_orderitems')}}
)

select 
products.product_id
,products.name
, min(orders.created_at) first_created_date
, max(orders.created_at) last_created_date
, count(orders.order_id) total_orders
from order_items
join orders
on orders.order_id = order_items.order_id
join stg_postgres_products as products
on order_items.product_id = products.product_id
group by 1,2
order by 1 