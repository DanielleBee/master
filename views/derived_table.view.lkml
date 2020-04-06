view: derived_table {
  derived_table: {
    sql: SELECT orders.id AS orderid, created_at, user_id, status, order_items.* FROM orders
      JOIN order_items
      ON orders.id = order_items.order_id
      WHERE created_at <= IFNULL({% date_end date_filter %}, '2037-01-01')
      AND returned_at >= IFNULL({% date_start date_filter %},'1900-01-01')
       ;;
  }

  filter: date_filter {
    type: date
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orderid {
    type: number
    sql: ${TABLE}.orderid ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  set: detail {
    fields: [
      orderid,
      created_at_time,
      user_id,
      status,
      id,
      order_id,
      sale_price,
      inventory_item_id,
      returned_at_time
    ]
  }
}
