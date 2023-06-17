with source as (

    SELECT "ID" as id, "ORDERID" as orderid, "PAYMENTMETHOD" as paymentmethod, "STATUS" as status, "AMOUNT" as amount, "CREATED" as created
    FROM stripe_payments

)
select * from source

