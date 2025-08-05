{% macro calculate_trend_metrics(metric_column, partition_column, order_column) %}
    -- 7-day moving average
    avg({{ metric_column }}) over (
        partition by {{ partition_column }}
        order by {{ order_column }}
        rows between 6 preceding and current row
    ) as {{ metric_column }}_7d_avg,

    -- 14-day moving average
    avg({{ metric_column }}) over (
        partition by {{ partition_column }}
        order by {{ order_column }}
        rows between 13 preceding and current row
    ) as {{ metric_column }}_14d_avg,

    -- 7-day % price change
    ({{ metric_column }} - lag({{ metric_column }}, 7) over (
        partition by {{ partition_column }}
        order by {{ order_column }}
    )) / nullif(lag({{ metric_column }}, 7) over (
        partition by {{ partition_column }}
        order by {{ order_column }}
    ), 0) * 100 as price_pct_change_7d,

    -- 14-day % price change
    ({{ metric_column }} - lag({{ metric_column }}, 14) over (
        partition by {{ partition_column }}
        order by {{ order_column }}
    )) / nullif(lag({{ metric_column }}, 14) over (
        partition by {{ partition_column }}
        order by {{ order_column }}
    ), 0) * 100 as price_pct_change_14d
{% endmacro %}