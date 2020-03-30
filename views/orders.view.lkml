view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: date_granularity {
    description: "Parameter of type: date_time to be used with { % condition % } sql_always_where on explore"
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

#   parameter: date_picker {
#     description: "Parameter of type: string"
#     type: date_time
#     default_value: "Last Month"
#     allowed_value: {value: "This Week"}
#     allowed_value: {value: "Last Week"}
#     allowed_value: {value: "This Month"}
#     allowed_value: {value: "Last Month"}
#     allowed_value: {value: "This Quarter"}
#     allowed_value: {value: "Last Quarter"}
#     allowed_value: {value: "6 months"}
#     allowed_value: {
#       label: "Year to date"
#       value: "This Year"
#     }
#     allowed_value: {value: "Last Year"}
#   }


  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      day_of_week_index,
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

#     html: <a href="/explore/danielle_test/orders_items?fields=orders.id,users.first_name,order_items.count&f[view_name.filter_1]={{ value }}&pivots=view.field_2">{{ value }}</a> ;;

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]
  }

  measure: count_of_days {
    type: count_distinct
    sql: ${created_date};;
  }

  measure: average_order_count_per_day {
    type: number
    sql: ${count}/${count_of_days} ;;
    value_format: "0.0"
  }


  measure: count_of_mondays {
    type: count_distinct
    sql: ${created_date} ;;
    filters: {
      field: created_day_of_week
      value: "Monday"
    }
  }

}
