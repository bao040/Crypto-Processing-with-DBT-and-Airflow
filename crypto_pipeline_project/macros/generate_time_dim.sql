{% macro generate_time_attributes(column_name) %}
    {{ column_name }} as raw_timestamp,
    to_char({{ column_name }}, 'YYYYMMDDHH24MISS')::bigint as time_id,
    cast({{ column_name }} as date) as date,
    extract(hour from {{ column_name }}) as hour,
    extract(dow from {{ column_name }}) as day_of_week,
    extract(month from {{ column_name }}) as month,
    extract(quarter from {{ column_name }}) as quarter,
    to_char({{ column_name }}, 'YYYY-MM') as year_month,
    to_char({{ column_name }}, 'YYYY-MM-DD HH24:00:00') as hour_block
{% endmacro %}


