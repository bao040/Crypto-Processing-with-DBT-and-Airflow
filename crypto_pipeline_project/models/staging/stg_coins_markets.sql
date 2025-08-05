{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'coins_markets') }}
),

renamed as (
    select
        cast(id as string) as id,
        lower(trim(symbol)) as symbol,
        initcap(trim(name)) as name,
        cast(current_price as float) as current_price,
        cast(market_cap as float) as market_cap,
        cast(total_volume as float) as total_volume,
        cast(circulating_supply as float) as circulating_supply,
        cast(timestamp as timestamp) as timestamp
    from source
)

select * from renamed

