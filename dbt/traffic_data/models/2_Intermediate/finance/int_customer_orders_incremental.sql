{{
    config(
        materialized='incremental',
        unique_key="customer_id",
        incremental_strategy="delete+insert",
        on_schema_change='fail'
    )
}}
with stg_orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

)

select * from stg_orders

{% if is_incremental() %}

where
  {% if var('start_date', false) != false %}
    order_date >= (select (max('{{ var('start_date') }}'))::date -3 from {{this}})
  {% else %}
    order_date >= (select (max(order_date))::date -3 from {{this}})
  {% endif %}

{% endif %}