{% snapshot customers_snapshot %}
    {{
        config(
            target_schema='jaffle_shop',
            target_database='raw',
            unique_key='id',
            strategy='check',
            check_cols= 'all',
            invalidate_hard_deletes=True, 
        )
    }}
-- Invalidate sets the dbt_valid_to  value from NULL to current_timestamp when the record is deleted

    select * from {{ source('jaffle_shop', 'customers') }}
 {% endsnapshot %}