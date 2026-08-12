select
    id as order_id,
    -- {{ function('if_positive') }}(id) as order_id_not_null,
    user_id as customer_id,
    order_date,
    status as order_status

from {{ source('jaffle_shop', 'orders') }}