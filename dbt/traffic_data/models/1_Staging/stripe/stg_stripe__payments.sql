{{ config(materialized='view') }}

with source as (

    SELECT id, orderid, paymentmethod, status, amount, created
    from stripe_payments

),
select * from source

