{{ config(
    materialized='view',
    schema='intermediate'
) }}

with timestamps as (
    select distinct timestamp
    from {{ ref('stg_coins_markets') }}
    where timestamp is not null
)

select
    {{ generate_time_attributes('timestamp') }}
from timestamps



