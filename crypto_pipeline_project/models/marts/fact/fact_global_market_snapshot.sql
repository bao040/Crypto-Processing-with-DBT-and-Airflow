{{ config(materialized='table') }}

select
    timestamp,
    total_market_cap_usd,
    total_volume_24h_usd,
    active_cryptocurrencies,
    market_cap_percentage,
    dbt_valid_from,
    dbt_valid_to
from {{ ref('dim_global_market') }}
where timestamp >= dateadd('day', -30, current_date)