{{
    config(
        materialized='incremental',
        unique_key="customer_id",
        incremental_strategy="delete+insert"
    )
}}
with stg_orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

)

select * from stg_orders

{% if is_incremental() %}

where
  order_date >= (select (max(order_date))::date -3 from {{this}})
{% endif %}