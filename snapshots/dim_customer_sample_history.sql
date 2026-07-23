{% snapshot dim_customer_sample_history %}

{{
config(
    target_database='DEV_BLUSKY_DW',
    target_schema='CURATED_JC',
    unique_key='CUSTOMER_ID',
    strategy='timestamp',
    updated_at='_UPDATE_TIMESTAMP'
)
}}

select *
from {{ ref('dim_customer_sample_stage') }}

    {% endsnapshot %}