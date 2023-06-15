
with stg_fast_vehicles as (
    
    SELECT *
    from trajectories 
    ORDER BY avg_speed DESC
    LIMIT 10000
)

select * from stg_fast_vehicles