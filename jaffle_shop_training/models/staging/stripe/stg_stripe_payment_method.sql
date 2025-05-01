  {% set payment_methods = ['credit_card','coupon','bank_transfer','gift_card'] %}
  
  with source as (
        select * from {{ source('stripe', 'payment') }}
  ),
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
    )
  select * from renamed
    