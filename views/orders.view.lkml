view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: date_granularity {
    type: date_time
    default_value: "Last Month"
    allowed_value: {value: "This Week"}
    allowed_value: {value: "Last Week"}
    allowed_value: {value: "This Month"}
    allowed_value: {value: "Last Month"}
    allowed_value: {value: "This Quarter"}
    allowed_value: {value: "Last Quarter"}
    allowed_value: {value: "6 months"}
    allowed_value: {
      label: "Year to date"
      value: "This Year"
    }
    allowed_value: {value: "Last Year"}
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]
#     html: <a href="/explore/danielle_test/orders_items?fields=orders.id,users.first_name,order_items.count&f[view_name.filter_1]={{ value }}&pivots=view.field_2">{{ value }}</a> ;;
  }
}
