-- base_jaffle_shop__customers.sql

with

source as (

    select * from {{ source('jaffle_shop','customers') }}

),

customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from customers