{{ config(
    materialized='table'
) }}

with customers as (

    select
        *,
        {{ dbt_utils.generate_surrogate_key(['first_name', 'last_name']) }} as name_sk
    from {{ ref('stg_jaffle_shop_customers') }}

),

orders as (

    select
        *
    from {{ ref('stg_jaffle_shop_orders') }}

),
payment as (
    select
        SUM(payment_amount) as lifetime_value,
        customer_id
    from {{ ref('fct_orders') }}
    --where status = 'success'
    group by customer_id
),

customer_orders as (

    select
        customer_id,

        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders

    from orders orders 

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.name_sk,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        customer_orders.number_of_orders,
        payment.lifetime_value
    from customers

    left join customer_orders using (customer_id)
    left join payment using (customer_id)

)

select * from final order by customer_id asc