with vehicles as (

    select * from {{ ref('stg_traffic__fast_vehicles')}}

),

with fast_vehicles as (
    SELECT *
    from vehicles 
    ORDER BY avg_speed DESC
    LIMIT 100
)


SELECT * FROM fast_vehicles

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
