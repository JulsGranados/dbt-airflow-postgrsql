
with customers as (
    
    SELECT "ID" AS customer_id , "FIRST_NAME" as first_name, "LAST_NAME" as last_name
    FROM jaffle_shop_customers
)

select * from customers