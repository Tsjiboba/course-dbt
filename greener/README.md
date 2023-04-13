# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## License
GPL-3.0


## PROJECT WEEK 1
Q: How many users do we have?
A: 130
    SELECT COUNT(DISTINCT(USER_ID)) FROM DEV_DB.DBT_RICOBOUWMANSMOLLIECOM.STG_USERS

Q: On average, how many orders do we receive per hour?
A: 7.52
WITH order_per_hour AS(SELECT 
    DATE_TRUNC(HOUR, CREATED_TIME)
    ,COUNT(*) as count_per_hour 
    FROM DEV_DB.DBT_RICOBOUWMANSMOLLIECOM.STG_ORDERS)

    SELECT AVG(count_per_hour) from order_per_hour

Q: On average, how long does an order take from being placed to being delivered?
A: 93.4
WITH DELIVERY_HOURS AS (SELECT ORDER_ID
, CREATED_AT
, DELIVERED_AT 
, datediff(hours, created_at, delivered_at) as delivery_hours
FROM DEV_DB.DBT_RICOBOUWMANSMOLLIECOM.STG_ORDERS)

SELECT AVG(delivery_hours) from DELIVERY_HOURS

Q: How many users have only made one purchase? Two purchases? Three+ purchases?
1: 25
2: 28
3: 89

WITH total AS (SELECT user_id, count(*) as count_orders  FROM DEV_DB.DBT_RICOBOUWMANSMOLLIECOM.STG_ORDERS 
group by 1 
)

SELECT count_orders, count(*) FROM total
group by 1
order by 1 desc

Q: On average, how many unique sessions do we have per hour?
16.3
WITH session_per_hour AS (
SELECT 
    date_trunc(hour,created_at) AS hour,
    count(distinct session_id) AS sessions
from DEV_DB.DBT_RICOBOUWMANSMOLLIECOM.STG_EVENTS
group by 1 
)

select 
    avg(sessions) as avg_hourly_sessions 
from session_per_hour