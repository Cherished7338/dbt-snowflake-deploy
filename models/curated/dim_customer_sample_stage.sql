{{
config(
    materialized='incremental',
    incremental_strategy='append',
    on_schema_change='sync_all_columns'
)
}}

with source_data as (

    select *
    from {{ source('curated','DIM_CUSTOMER_SAMPLE') }}

)

select source_data.*
from source_data

    {% if is_incremental() %}

left join {{ this }} existing
on source_data.CUSTOMER_ID = existing.CUSTOMER_ID

where existing.CUSTOMER_ID is null
   or source_data._UPDATE_TIMESTAMP > existing._UPDATE_TIMESTAMP

{% endif %}