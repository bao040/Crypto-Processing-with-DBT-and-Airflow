{{ config(
    materialized = 'incremental',
    unique_key = ['coin_id', 'time_id'],
    incremental_strategy = 'merge',
    on_schema_change = 'append_new_columns'
) }}

select
    coin_id,
    time_id,
    current_price,
    market_cap,
    total_volume,
    circulating_supply,
    market_cap_category,
    current_price_7d_avg,
    current_price_14d_avg,
    price_pct_change_7d,
    price_pct_change_14d
from {{ ref('int_fact_market_metrics') }}
where coin_id is not null and time_id is not null
{% if is_incremental() %}
  and time_id > (select max(time_id) from {{ this }})
{% endif %}

