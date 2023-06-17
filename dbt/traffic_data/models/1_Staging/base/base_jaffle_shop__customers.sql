-- base_jaffle_shop__customers.sql

with custo as (

    select * from jaffle_shop_customers

),

customers as (

    select
        "ID" as customer_id,"FIRST_NAME" as first_name, "LAST_NAME" as last_name
    from custo

)

select * from customers