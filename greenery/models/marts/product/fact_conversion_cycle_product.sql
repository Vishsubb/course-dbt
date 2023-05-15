{{ 
    config(
        materialized='table'
    )
}}

with session_events as (
    select *
    from {{ ref ('int_session_product_agg') }}
),


final as (
    select 
    div0(sum(checkouts), count(distinct product_id))  from session_events
)

select *
from final