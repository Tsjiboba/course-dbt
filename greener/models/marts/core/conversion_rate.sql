
{{
 config(
    MATERIALIZED = "table"
 )
}}  

WITH int_page_views AS (SELECT * FROM
{{ ref('int_page_views') }}
)

SELECT 
div0(sum(total_checkouts), count(distinct session_id)) as conversion_rate
FROM int_page_views