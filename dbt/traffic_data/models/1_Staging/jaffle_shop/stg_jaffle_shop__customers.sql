{{ config(materialized='view') }}
with customers as (
    
    SELECT "ID" AS "CUSTOMER_ID", "FIRST_NAME", "LAST_NAME"
    FROM jaffle_shop_customers
)

select * from customers