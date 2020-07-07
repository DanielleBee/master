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

  filter: date_filter_1 {
    type: date
  }

  filter: date_filter_2 {
    type: date
  }

  dimension: is_due_before_created_date {
    type: yesno
    sql: DATEDIFF(${created_date}, {% date_end date_filter_1 %}) >= 0 ;;
  }

  dimension: time_period_filtered {
    type: string
    sql:  CONCAT(CAST({% date_start date_filter_1 %} as date), " to ", cast({% date_end date_filter_1 %} as date));;
  }

#  CASE WHEN DATEDIFF(EXTRACT(DAY FROM {% date_end date_filter_1 %}), EXTRACT(DAY FROM {% date_start date_filter_1 %})) = 1 THEN {% date_start date_filter_1 %}
#     ELSE

  parameter: date_granularity {
    description: "Parameter of type: date_time to be used with { % condition % } sql_always_where on explore"
    type: date_time
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
      time_of_day,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      day_of_month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: week_of_year_filter {
    type: yesno
    sql: ${created_week_of_year} <= WEEK(NOW()) ;;
  }

  dimension: created_week_of_year_test {
    type: date_week_of_year
    sql: case when ${created_week_of_year} <= WEEK(NOW()) then ${created_week_of_year} else null end ;;
  }

measure: filtered_count_week_of_year {
  type: count_distinct
  sql: case when ${created_week_of_year} <= WEEK(NOW()) then ${id} else null end ;;
}

  dimension: last_day_of_range {
    type: date
    datatype: date
    sql: {% date_end created_date %} ;;
  }

  dimension_group: fiscal_test {
    type: time
    allow_fill: no
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
      time,
      time_of_day,
      year
    ]
    sql: ${TABLE}.created_at ;;
#     html: Fiscal {{value}} ;;
  }

####### HOW TO SHOW JUST TIME ON AN AXIS IN A CHART
  dimension: seconds {
    description: "Time of day reflected as seconds"
    type: number
    sql: (extract(hour from ${created_raw}) *60*60) + (extract(minute from ${created_raw}) * 60) + extract(seconds from ${created_raw}) ;;
  }

  dimension: seconds_formatted_as_time {
    description: "Time of day reflected as h:mm:ss"
    type: number
    sql: sql: ${seconds}/ 86400.0 ;;
    value_format: "h:mm:ss"
  }

# To contend with timezone conversions, we can also hard code in a timezone conversion into our seconds calculation,
# or we can create a parameter that lists out different timezones that we can use to add/subtract the number of hours accordingly

######

  dimension: fiscal_month {
    type: date_fiscal_month_num
# type: date
    sql: CASE WHEN ${created_date} = CAST("2019-09-30" AS DATE) THEN CAST("2019-10-01" AS DATE) ELSE ${created_date} END ;;
#     sql: CASE WHEN ${created_date} = CAST("2019-09-30" AS DATE);;
    html: Fiscal Month {{ value }} ;;
  }

  dimension: time_of_day {
    type: number
    sql: CAST("1705" AS SIGNED) ;;
    value_format: "0"
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_case_when {
    type: string
    case: {
    when: {
    sql: ${TABLE}.status = "pending" ;;
      label: "pending"
    }
    when: {
      sql: ${TABLE}.status = "cancelled" ;;
      label: "cancelled"
    }
    when: {
      sql: ${TABLE}.status = "complete" ;;
      label: "complete"
    }
    }
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

  measure: min_date_measure {
    type: date
    sql: min(${created_date} ;;
  }

  measure: count_of_days {
    type: count_distinct
    sql: ${created_date};;
  }

  measure: order_count_date_range_1 {
    type: count_distinct
    sql: case when ${created_date} > {% date_start date_filter_1 %} and ${created_date} <= {% date_end date_filter_1 %} then ${id} end ;;
  }

  measure: order_count_date_range_2 {
    type: count_distinct
    sql: case when ${created_date} >= {% date_start date_filter_2 %} and ${created_date} < {% date_end date_filter_2 %} then ${id} end ;;
  }

  measure: order_count_date_range_3 {
    type: count_distinct
    sql: case
    when ${created_date} >= {% date_start date_filter_1 %} then ${id}
    end ;;
  }

  measure: difference_between_count_date_ranges {
    type: number
    sql: ${order_count_date_range_1}-${order_count_date_range_2} ;;
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

  measure: filtered_order_count {
    type: count
    filters: [created_day_of_week: "Monday"]
  }

  measure: filtered_order_count_case_when {
    type: count_distinct
    sql: case when ${created_date} = ${created_week} then ${id} end ;;
  }

  measure: count_for_week_start_day {
    type: number
    sql: {% if orders.created_week._in_query %}
    ${filtered_order_count}
    {% else %}
    ${count}
    {% endif %};;
  }

}
