{% snapshot orders_snapshot %}

{{
    config(
      target_database='postgres',
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols=['customer_id','order_date','status'],
    )
}}

select * from  {{ ref('stg_jaffle_shop__orders') }}

{% endsnapshot %}