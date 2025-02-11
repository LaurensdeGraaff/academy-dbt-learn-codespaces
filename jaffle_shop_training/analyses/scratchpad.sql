{# select * from dbt_lgraaff.dim_customers;
 #}

 select * from {{ref('fct_orders')}}
 where payment_status NOT IN ('returned','completed','shipped','return_pending','placed')