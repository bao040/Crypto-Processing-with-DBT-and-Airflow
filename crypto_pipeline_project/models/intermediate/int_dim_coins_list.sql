{{ config(materialized='view') }}

with base as (
    select * from {{ ref('stg_coins_list') }}
),

inter as (
    select
        id,
        symbol,
        name
    from base
)

select * from inter

