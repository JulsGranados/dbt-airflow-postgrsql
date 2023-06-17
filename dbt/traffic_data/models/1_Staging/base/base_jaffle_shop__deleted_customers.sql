-- base_jaffle_shop__deleted_customers.sql

with

source as (

     select * from jaffle_shop_customers

),

deleted_customers as (

    SELECT "ID" as customer_id , current_date as deleted_at 
    FROM source

)

select * from deleted_customers