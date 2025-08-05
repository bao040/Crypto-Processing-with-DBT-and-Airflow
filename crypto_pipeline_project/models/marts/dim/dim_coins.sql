{{ config(materialized='table') }}

select distinct
    coin_id,
    symbol,
    name,
    market_cap_category
from {{ ref('int_fact_market_metrics') }}
where coin_id is not null