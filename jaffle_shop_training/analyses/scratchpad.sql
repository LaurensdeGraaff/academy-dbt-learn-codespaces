{# select * from dbt_lgraaff.dim_customers;
 #}

 select order_status from {{ref('stg_jaffle_shop_orders')}}
 where order_status NOT IN ('returned','comnpleted','return_pending','shipped','placed')
 group by order_status