

with top_speed as (select * from {{ref('int_timely_agg_by_type')}})

SELECT 
*
from top_speed
ORDER BY "lon_acc" ASC
LIMIT(100)

