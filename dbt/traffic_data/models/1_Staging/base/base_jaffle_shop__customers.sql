-- base_jaffle_shop__customers.sql

with custo as (

    select * from jaffle_shop_customers

),

customers as (

    select
        "ID" as customer_id,"FIRST_NAME", "LAST_NAME"
    from custo

)

select * from customers