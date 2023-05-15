{% macro session_dimension(table_name, column_name, groupby_name) %}

{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_postgres_events'), column='event_type')
%}

with events as (
    select * from {{ table_name }}
)
, prefinal as 
(
select  {{ groupby_name }}
    {%- for event_type in event_types %}
    , sum (case when event_type='{{ event_type }}' then 1 else 0 end) as {{event_type}}s
    {%- endfor %}
   from events
group by 1
order by 1
)
select * from prefinal
{% endmacro %}