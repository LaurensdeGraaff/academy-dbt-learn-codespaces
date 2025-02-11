{{ config(
    materialized='table'
) }}

with payment as (

    select
        order_id,
        payment_id,
        --sum(amount) as total_amount,
        payment_amount as payment_amount,
        payment_status
    from {{ ref('stg_stripe_payment') }}
    where payment_status = 'success'
    --group by customer_id

),
orders as (

    select
        *
    from {{ ref('stg_jaffle_shop_orders') }}

),

final as (

    select
        customer_id,
        order_id,
        payment_status,
        payment_amount,
        order_status
    from orders

    left join payment using (order_id)
)

select * from final