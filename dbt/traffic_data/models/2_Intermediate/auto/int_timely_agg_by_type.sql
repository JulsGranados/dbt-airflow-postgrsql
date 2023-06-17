with timely as (

    select * from {{ ref('stg_traffic__timely')}}

),

timely_summary as (
    SELECT 
    time,
    Round(AVG(Cast(speed as numeric)),2) as "speed",
    Round(AVG(Cast(lat_acc as numeric)),2) as "lat_acc",
    Round(AVG(Cast(lon_acc as numeric)),2) as "lon_acc"
    from timely
    GROUP BY "time"
)


SELECT * FROM timely_summary
    