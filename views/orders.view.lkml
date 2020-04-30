view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: single_value_vis_test {
    type: string
    sql: "Single Value Vis Test" ;;
    html:  <center><font color="#5A2FC2" size="12" >{{ value }}</font></center>;;
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

#   filter: date_filter {
#     type: date
#   }

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
      month_name,
      day_of_month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: fiscal_test {
    type: time
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      day_of_month,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
#     html: Fiscal {{value}} ;;
  }

  dimension: fiscal_month {
    type: date_fiscal_month_num
# type: date
    sql: CASE WHEN ${created_date} = CAST("2019-09-30" AS DATE) THEN CAST("2019-10-01" AS DATE) ELSE ${created_date} END ;;
#     sql: CASE WHEN ${created_date} = CAST("2019-09-30" AS DATE);;
    html: Fiscal Month {{ value }} ;;
  }

  dimension: fiscal_week {
    type: date_week_of_year
    sql: ${TABLE}.created_at ;;
    html: Fiscal Week {{ value }} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: ampersand_test_status {
    type: string
    sql: CONCAT(${TABLE}.status, ' & fulfilled') ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

#     html: <a href="/explore/danielle_test/orders_items?fields=orders.id,users.first_name,order_items.count&f[view_name.filter_1]={{ value }}&pivots=view.field_2">{{ value }}</a> ;;


######## MEASURES ############


  measure: count {
    label: "Order Count"
    type: count
#     html: Order Count: {{value}} | Percent of Total: {{ orders.percent_of_total_count._rendered_value }} ;;
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]
  }

  measure: percent_of_total_count {
    type: percent_of_total
    value_format_name: decimal_2
    sql: ${count} ;;
  }

  measure: first_order_date {
    type: date
    sql: min(${created_date}) ;;
  }

  measure: count_yesterday {
    type: count_distinct
    sql: ${id} ;;
    filters: [created_date: "6 months ago"]
    }

  measure: count_one_week_ago {
    type: count_distinct
    sql:  ${id}  ;;
    filters: [created_date: "8 months ago"]
  }

  measure: average_cancelled {
    type: average
    value_format_name: decimal_0
    sql:  ${id} ;;
    filters: {
      field: status
      value: "cancelled"
    }
  }

  dimension: dummy_dimension {
    case: {
      when: {
        label: "Average Complete"
        sql: 1=1 ;;
      }
      when: {
        label: "Average Cancelled"
        sql: 1=1 ;;
      }
      when: {
        label: "Average Pending"
        sql: 1=1 ;;
      }
    }
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
