
{{
 config(
    MATERIALIZED = "table"
 )

}}

WITH orders as (SELECT *
FROM {{ ref('stg_orders') }})

, order_items as (SELECT *
FROM {{ ref('stg_order_items') }})

, products as (SELECT *
FROM {{ ref('stg_products') }})

SELECT o.*
, oi.product_id as product_id
, p.name
FROM ORDERS O
LEFT JOIN ORDER_ITEMS OI
ON o.order_id = oi.order_id
LEFT JOIN PRODUCTS p
ON oi.product_id = p.product_id