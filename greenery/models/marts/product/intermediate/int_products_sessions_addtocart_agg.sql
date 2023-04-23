
{{config(
    materialized = 'table'
)
}}

select stg_postgres_products.product_id
, stg_postgres_products.name
, event_type
, count(event_id) event_agg 
from stg_postgres_events 
right join stg_postgres_products
on stg_postgres_events.product_id = stg_postgres_products.product_id 
join stg_postgres_users 
on stg_postgres_users.user_id = stg_postgres_events.user_id
where event_type = 'add_to_cart'
group by 1,2,3 order by 2,3