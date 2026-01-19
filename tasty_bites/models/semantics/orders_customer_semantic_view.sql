{{
  config(
    materialized='semantic_view'
  )
}}

tables (
    orders AS {{ ref('orders') }} primary key (order_id, order_detail_id),
    customer_loyalty AS {{ ref('customer_loyalty_metrics') }} primary key (customer_id)
)

relationships (
    orders_to_customer AS orders(customer_id) references customer_loyalty(customer_id)
)

facts (
    orders.quantity as quantity,
    orders.order_total as order_total,
    customer_loyalty.total_sales as total_sales
)

dimensions (
    orders.order_id as order_id,
    orders.truck_id as truck_id,
    orders.menu_item_name as menu_item_name,
    orders.customer_id as customer_id,
    orders.location_id as location_id
)

metrics (
    orders.total_quantity as SUM(quantity),
    orders.total_order_value as SUM(order_total),
    customer_loyalty.customer_lifetime_value as SUM(total_sales)
)
