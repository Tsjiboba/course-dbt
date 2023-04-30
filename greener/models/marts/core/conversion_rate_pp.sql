
{{
 config(
    MATERIALIZED = "table"
 )
}}  

WITH int_page_views AS (SELECT * FROM
{{ ref('stg_events') }}
where event_type = 'page_view'
)

, page_views_pp AS (SELECT product_id
, count(distinct event_id) as page_views_pp
FROM int_page_views
group by 1)

, orders AS (SELECT * FROM
{{ ref('orders') }}
)

, orders_pp AS  (SELECT product_id
, count(distinct order_id) as orders_pp
FROM orders
group by 1 )

SELECT p.*
, o.orders_pp
, div0( o.orders_pp, p.page_views_pp) as conversion_rate_pp
FROM page_views_pp AS p
LEFT JOIN orders_pp AS o
ON p.product_id = o.product_id