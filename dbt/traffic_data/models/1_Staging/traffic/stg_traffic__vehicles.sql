
with stg_vehicles as (
    
    select
    TRIM(type) as type,
    traveled_d,
    avg_speed
    from trajectories 
)

select * from stg_vehicles