{# select * from dbt_lgraaff.dim_customers;
 #}

 select sum(amount) from {{ref('fct_orders')}}