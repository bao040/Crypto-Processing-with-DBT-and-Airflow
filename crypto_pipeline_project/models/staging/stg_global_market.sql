{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'global_market') }}
),

renamed as (
    select
        cast(timestamp as timestamp) as timestamp,
        cast(total_market_cap_usd as float) as total_market_cap_usd,
        cast(total_volume_24h_usd as float) as total_volume_24h_usd,
        cast(active_cryptocurrencies as int) as active_cryptocurrencies,
        cast(market_cap_percentage as string) as market_cap_percentage
    from source
)

select * from renamed
