{{ config(
    materialized = 'table'
) }}

with int_dim_time as (
    select *
    from {{ ref('int_dim_time') }}
)

select *
from int_dim_time
