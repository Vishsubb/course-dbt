{{config(
    materialized = 'table'
)
}}

with final as 
(
    select * from ( {{session_dimension('stg_postgres_events', 'event_type', 'product_id')}})
)
select * from final