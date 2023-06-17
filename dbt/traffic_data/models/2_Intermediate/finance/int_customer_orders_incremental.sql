{{
    config(
        materialized='incremental',
        unique_key='USER_ID'
    )
}}
stg_orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

select * from stg_orders

{% if is_incremental() %}

where
  "ORDER_DATE" >= (select dateadd(day, -3, max("ORDER_DATE")::date) from {{this}})
{% endif %}