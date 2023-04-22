{{
 config(
    MATERIALIZED = "table"
 )

}}

WITH sessions as (SELECT *
FROM {{ ref('int_page_views') }})

, users as (SELECT *
FROM {{ ref('stg_users') }})

SELECT sessions.*
, users.first_name
, users.last_name
, users.email
FROM sessions
LEFT JOIN users 
    ON sessions.user_id = users.user_id
