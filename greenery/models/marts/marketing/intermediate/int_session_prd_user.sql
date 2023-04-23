{{config(
    materialized = 'table'
)
}}
select product_id, 
    user_id 
    , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view_events
    , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart_events
    , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped_events
    , sum(case when event_type = 'checkout' then 1 else 0 end) as checkout_events    
    , MIN(created_at) as session_start_at
    , MAX(created_at) as session_end_at
from stg_postgres_events
group by 1,2
order by 1