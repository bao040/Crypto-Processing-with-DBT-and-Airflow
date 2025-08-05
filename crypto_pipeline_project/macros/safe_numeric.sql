{% macro safe_numeric(column) %}
    coalesce({{ column }}, 0)
{% endmacro %}
