{% snapshot dim_global_market %}

{{ config(
    target_schema='snapshots',
    strategy='check',
    unique_key='timestamp',
    check_cols=[
        'total_market_cap_usd',
        'total_volume_24h_usd',
        'active_cryptocurrencies',
        'market_cap_percentage'
    ]
) }}

select
    timestamp,
    total_market_cap_usd,
    total_volume_24h_usd,
    active_cryptocurrencies,
    market_cap_percentage
from {{ ref('stg_global_market') }}

{% endsnapshot %}
