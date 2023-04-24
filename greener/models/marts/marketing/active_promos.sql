
{{
 config(
    MATERIALIZED = "table"
 )

}}

WITH orders as (SELECT *
FROM {{ ref('stg_orders') }})

, promos as (SELECT *
FROM {{ ref('stg_promos') }})

SELECT o.*
, p.discount
,p.status AS promo_status
FROM ORDERS o
LEFT JOIN PROMOS p
ON o.promo_id = p.promo_id
WHERE o.promo_id is not null