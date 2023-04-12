{{
  config(
    materialized='table'
  )
}}

SELECT *
FROM {{ source('postgres', 'products') }}
