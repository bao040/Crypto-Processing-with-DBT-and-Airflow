{{ config(
    materialized = 'incremental',
    unique_key = ['coin_id', 'timestamp'],
    on_schema_change = 'append_new_columns'
) }}

with coins as (
    select * from {{ ref('stg_coins_markets') }}
    {% if is_incremental() %}
      where timestamp > (select max(timestamp) from {{ this }})
    {% endif %}
),

coin_info as (
    select * from {{ ref('stg_coins_list') }}
),

dim_time as (
    select * from {{ ref('int_dim_time') }}
),

joined as (
    select
        coins.id as coin_id,
        coins.symbol,
        coins.name,
        coins.timestamp,
        to_char(coins.timestamp, 'YYYYMMDDHH24MISS')::bigint as coins_time_id,
        {{ safe_numeric('coins.current_price') }} as current_price,
        {{ safe_numeric('coins.market_cap') }} as market_cap,
        {{ safe_numeric('coins.total_volume') }} as total_volume,
        {{ safe_numeric('coins.circulating_supply') }} as circulating_supply,
        dim_time.time_id
    from coins
    left join coin_info on coins.id = coin_info.id
    left join dim_time on coins_time_id = dim_time.time_id
),

with_trends as (
    select
        *,
        case 
            when market_cap >= 10000000000 then 'Large Cap'
            when market_cap >= 1000000000 then 'Mid Cap'
            else 'Small Cap'
        end as market_cap_category,
        {{ calculate_trend_metrics('current_price', 'coin_id', 'time_id') }}
    from joined
)

select * from with_trends
