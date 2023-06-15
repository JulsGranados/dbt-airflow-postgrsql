with fast_v as (select * from {{ref('int_fast_vehicles_top')}})

SELECT 
type as "Vehicle type",
count(type) as "vehicle count"
from fast_v 
GROUP BY type ORDER BY "vehicle count" ASC
    