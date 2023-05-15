/*{{config(
    materialized = 'table'
)
}}

{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_postgres_events'), column='event_type')
%}

with events as (
    select * from stg_postgres_events
)
, final as 
(
select session_id
    {%- for event_type in event_types %}
    , sum (case when event_type='{{ event_type }}' then 1 else 0 end) as {{event_type}}s
    {%- endfor %}
   from events
group by 1
order by 1
)
select * from final*/

{{config(
    materialized = 'table'
)
}}

with final as 
(
    select * from ( {{session_dimension('stg_postgres_events', 'event_type', 'session_id')}})
)
select * from final