{{ config(materialzied='table')}}
with stg_orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

 customer_orders as (
  
select 
    customer_id as customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(order_id) as num_of_orders
from stg_orders
group by 1
  
)

SELECT * from customer_orders