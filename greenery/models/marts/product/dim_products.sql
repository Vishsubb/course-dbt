{{config(
    materialized = 'table'
)
}}

with products as (
    select * from {{ref('stg_postgres_products')}}
)

, sessionviews as (
    select
        * 
    from {{ref('int_products_sessions_agg')}}
)

, orders as (
    select * from {{ref('int_products_orderitems_agg')}}
)

select products.product_id
, products.name
, price
, inventory
, orders.total_orders
, orders.first_created_date
, orders.last_created_date
, sessionviews.page_view_count
, sessionviews.add_to_cart_count
, sessionviews.prod_conversion
from
products
join sessionviews
on sessionviews.product_id = products.product_id
join orders
on orders.product_id = products.product_id 