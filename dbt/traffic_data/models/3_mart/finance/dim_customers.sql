with customers as (

    select * from {{ ref('stg_jaffle_shop__customers')}}

),

customer_orders as (

    select * from {{ ref('int_customer_orders') }}

),

final as (

    select
        customers."CUSTOMER_ID",
        customers."FIRST_NAME",
        customers."LAST_NAME",
        customer_orders."FIRST_ORDER_DATE",
        customer_orders."MOST_RECENT_ORDER_DATE",
        coalesce(customer_orders."NUMBER_OF_ORDERS", 0) as "NUMBER_OF_ORDERS"

    from customers

    left join customer_orders using ("CUSTOMER_ID")

)

select * from final