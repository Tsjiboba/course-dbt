{{
 config(
    MATERIALIZED = "table"
 )

}}

WITH events as (SELECT *
FROM {{ ref('stg_events') }})

, sessions as (SELECT session_id
, user_id
, SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
, SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
, SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout
, SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped
, MIN(created_at) AS min_created_at
, MAX(created_at) AS max_created_at
FROM events
GROUP by 1, 2
)

SELECT * FROM sessions

