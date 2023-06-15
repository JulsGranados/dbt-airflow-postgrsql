stg_orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

with customer_orders as (
  
select 
"CUSTOMER_ID",
min("ORDER_DATE") as "FIRST_ORDER_DATE",
max("ORDER_DATE") as "MOST_RECENT_ORDER_DATE",
count("ORDER_ID") as "NUMBER_OF_ORDERS"
from stg_orders
group by 1
  
)

SELECT * from customer_orders