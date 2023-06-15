{{ config(materialized='view') }}
with stg_timely as (
    
    SELECT 
    time,
    speed,
    lat_acc,
    lon_acc
    from vehicles
)

select * from stg_timely