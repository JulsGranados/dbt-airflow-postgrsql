
with stg_fast_vehicles as (
    
    SELECT 
           track_id,
           TRIM(type) as type,
           traveled_d,
           avg_speed
    from trajectories 
    ORDER BY avg_speed DESC
    LIMIT 10000
)

select * from stg_fast_vehicles