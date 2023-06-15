
with orders as (
    
    SELECT "ID" AS "ORDER_ID", "USER_ID" AS "CUSTOMER_ID", "ORDER_DATE", "STATUS"
    from jaffle_shop_orders
)

select * from orders