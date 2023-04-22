{{
 config(
    MATERIALIZED = "table"
 )

}}

WITH users as (SELECT *
FROM {{ ref('stg_users') }})

, addresses as (SELECT *
FROM {{ ref('stg_addresses') }})

SELECT u.*
, a.address
, a.zipcode
, a.state
FROM users as U
LEFT JOIN addresses as A
ON a.address_id = u.address_id