{{config(
    materialized = 'table'
)
}}

with users as (
    select * from {{ref ('stg_postgres_users')}}
)

, addresses as (
    select * from {{ref('stg_postgres_addresses')}}
)

select
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at
    , updated_at
    , address
    , state
    , zipcode
    , country
from users
join addresses 
    on users.address_id = addresses.address_id