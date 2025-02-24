with source as (
        select * from {{ source('stripe', 'payment') }}
  ),
  {% set payment_methods = ['credit_card','coupon','bank_transfer','gift_card' ]%}

  renamed as (
      select
          ORDERID as order_id,
          {%for payment_method in payment_methods%}
          {{amount_per_method(payment_method)}} as {{payment_method}}_total_amount
          {%- if not loop.last-%}
          ,
          {%-endif-%}
          {%-endfor-%}
      from source
      group by 1
  )
  select * from renamed
    