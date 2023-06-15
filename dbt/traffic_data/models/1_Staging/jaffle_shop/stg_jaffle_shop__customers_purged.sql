-- stg_jaffle_shop__customers.sql

with

customers as (

    select * from {{ ref('base_jaffle_shop__customers') }}

),

deleted_customers as (

    select * from {{ ref('base_jaffle_shop__deleted_customers') }}

),

join_and_mark_deleted_customers as (

    select
        customers.*,
        case
            when deleted_customers.deleted_at is not null then true
            else false
        end as is_deleted

    from customers

    left join deleted_customers on customers.customer_id = deleted_customers.customer_id
   
)

select * from join_and_mark_deleted_customers