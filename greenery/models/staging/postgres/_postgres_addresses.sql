{{
  config(
    materialized='table'
  )
}}

SELECT 
ADDRESS_ID, ADDRESS, lpad(ZIPCODE,5,0) ZIPCODE, STATE, COUNTRY
FROM {{ source('postgres', 'addresses') }}