{{
  config(
    materialized='table'
  )
}}

SELECT order_id
, CAST(created_at AS TIMESTAMP) as created_time
, order_total
FROM {{ source('postgres', 'orders') }}
