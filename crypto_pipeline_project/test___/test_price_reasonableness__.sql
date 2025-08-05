-- This will fail if current_price < 0 or > 2x avg in 7d
with price_data as (
    select
        coin_id,
        current_price,
        current_price_7d_avg
    from {{ ref('int_fact_market_metrics') }}
)
select *
from price_data
where current_price < 0
   or current_price > 2 * current_price_7d_avg



