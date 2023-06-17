{{ config(materialzied='table')}}
with stg_stripe_payments as (

    select * from {{ ref('stg_stripe__payments') }}

),
renamed as (

    select
        -- ids
        id as payment_id,
        orderid as order_id,

        -- strings
        paymentmethod as payment_method,
        case
            when paymentmethod in ('stripe', 'paypal', 'credit_card', 'gift_card') then 'credit'
            else 'cash'
        end as payment_type,
        status,

        -- numerics
        amount as amount_cents,
        amount/ 100.0 as amount,
        
        -- booleans
        case
            when status = 'successful' then true
            else false
        end as is_completed_payment,

        -- dates
        created::date as created_date,

        -- timestamps
       created::timestamp as created_at

    from stg_stripe_payments

)

select * from renamed