{{ 
    config(
        materialized='table'
    )
}}

with session_events as (
    select *
    from {{ ref ('int_session_agg') }}
),


final as (
    select 
    div0(sum(checkouts), count(distinct session_id))  from session_events
)

select *
from final