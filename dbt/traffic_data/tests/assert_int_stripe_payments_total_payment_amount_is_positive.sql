-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail
select
    payment_id,
    sum(amount_cents) as total_amount_cents
from {{ ref('int_stripe_payments' )}}
group by payment_id
having  sum(amount_cents) < 0