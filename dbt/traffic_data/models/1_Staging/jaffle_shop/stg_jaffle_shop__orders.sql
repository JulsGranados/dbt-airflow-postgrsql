
with orders as (
    
    SELECT "ID" AS order_id, "USER_ID" AS  customer_id, "ORDER_DATE"::date as  order_date, "STATUS" as status
    from jaffle_shop_orders
)

select * from orders