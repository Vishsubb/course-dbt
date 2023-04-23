{{config(
    materialized = 'table'
)
}}

with session_agg as (
select  *  from {{ ref('int_session_prd_user') }} 
)


select session_agg.user_id
, first_name
, last_name
, email
, PHONE_NUMBER
, sum(session_agg.page_view_events) page_view_events
, sum(session_agg.checkout_events) checkout_events
, sum(session_agg.add_to_cart_events) add_to_cart_events
, sum(session_agg.package_shipped_events) package_shipped_events
, min(session_start_at) session_start_at
, max(session_end_at) session_end_at
from session_agg
join stg_postgres_users 
on session_agg.user_id = stg_postgres_users.user_id
group by 1,2,3,4,5
