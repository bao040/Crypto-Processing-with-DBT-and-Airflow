{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'coins_list') }}
),

renamed as (
    select
        cast(id as string) as id,
        lower(trim(symbol)) as symbol,
        initcap(trim(name)) as name
    from source
)

select * from renamed
