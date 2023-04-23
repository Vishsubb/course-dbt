{{config(
    materialized = 'table'
)
}}

with product_addtocart_view as (
    select * from {{ref('int_products_sessions_addtocart_agg')}}
)

, product_pageview_view as (
    select * from {{ref('int_products_sessions_pageview_agg')}}
)

select page_view.product_id
, page_view.name
,page_view.event_agg page_view_count
,add_to_cart.event_agg add_to_cart_count
,DIV0NULL( add_to_cart_count ,page_view_count ) prod_conversion
from product_pageview_view as page_view
left join product_addtocart_view as add_to_cart
on page_view.product_id = add_to_cart.product_id