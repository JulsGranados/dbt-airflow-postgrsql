with stg_vehicles as (

    select * from {{ ref('stg_traffic__vehicles')}}

),

with summary as (
  
    SELECT 
    type as "Vehicle type",
    count(type) as "vehicle count",
    Round(AVG(Cast(traveled_d as numeric)),2) as "Avg distance traveled",
    Round(AVG(cast(avg_speed as numeric)),2) as "Avg speed by vehicle"
    from stg_vehicles 
    GROUP BY type ORDER BY "vehicle count" ASC
  
)

SELECT * from summary