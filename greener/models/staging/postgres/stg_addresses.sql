{{
  config(
    materialized='table'
  )
}}

SELECT address_id
, address
, zipcode
, state
FROM {{ source('postgres', 'addresses') }}
