{%- macro amount_per_method(method) -%}
   (SUM(CASE WHEN PAYMENTMETHOD = '{{method}}' then amount else 0 end))
{%- endmacro -%}



