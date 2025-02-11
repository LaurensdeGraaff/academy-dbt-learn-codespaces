with source as (
        select * from {{ source('stripe', 'payment') }}
  ),
  renamed as (
      select
          ID as payment_id,
          ORDERID as order_id,
          cast((AMOUNT/100) as numeric(10, 2)) as payment_amount,
          STATUS as payment_status,
          PAYMENTMETHOD as payment_method,
          CREATED AS created_at,
          _BATCHED_AT as _batched_at

      from source
  )
  select * from renamed
    