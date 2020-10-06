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
    # html: <div class="vis" background-color="blue">{{value}}</div> ;;
# html: <div class="alert alert-info vis">
# <div class="card-header">
# <br> <font color="#282828" size="8">
# <center><span class="label label-primary">Chat Reviews Monitor</span></center>;;
}

  dimension: text_tile {
    type: string
    sql: 1 ;;
  html: <div class="vis">
  <font color="#282828" size="6">
  <center><span class="label label-primary">Chat Reviews Monitor</span></center>;;
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
    # link: {
      # label: "drill to pie chart"
# #       url: "https://master.dev.looker.com/explore/danielle_test/order_items?fields=orders.count,orders.status&f[orders.created_date]={{ orders.created_date._value }}&f[orders.created_month]={{ _filters['orders.created_month'] | url_encode }}&f[orders.status]={{ _filters['orders.status'] | url_encode }}&sorts=orders.count+desc&limit=500&column_limit=50&vis=%7B%22value_labels%22%3A%22legend%22%2C%22label_type%22%3A%22labPer%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22y_axes%22%3A%5B%5D%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22normal%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22series_types%22%3A%7B%7D%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22ordinal%22%2C%22x_axis_datetime_label%22%3A%22%25B%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22editable%22%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22column_order%22%3A%5B%22%24%24%24_row_numbers_%24%24%24%22%2C%22users.created_month%22%2C%22Men_calculation_1%22%2C%22Men_orders.count%22%2C%22Women_orders.count%22%2C%22Women_calculation_1%22%5D%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22orders.count%22%3A%7B%22is_active%22%3Afalse%7D%7D%2C%22type%22%3A%22looker_pie%22%2C%22defaults_version%22%3A1%2C%22hidden_fields%22%3Anull%2C%22show_null_points%22%3Atrue%2C%22interpolation%22%3A%22linear%22%7D&filter_config=%7B%22orders.created_date%22%3A%5B%7B%22type%22%3A%22on%22%2C%22values%22%3A%5B%7B%22date%22%3A%222020-07-09T21%3A17%3A37.154Z%22%2C%22unit%22%3A%22day%22%2C%22tz%22%3Atrue%7D%5D%2C%22id%22%3A3%2C%22error%22%3Afalse%7D%5D%2C%22orders.created_month%22%3A%5B%7B%22type%22%3A%22past%22%2C%22values%22%3A%5B%7B%22constant%22%3A%228%22%2C%22unit%22%3A%22mo%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%2C%22orders.status%22%3A%5B%7B%22type%22%3A%22%21empty%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22%22%7D%2C%7B%7D%5D%2C%22id%22%3A4%2C%22error%22%3Afalse%7D%2C%7B%22type%22%3A%22%21%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22pending%22%7D%2C%7B%7D%5D%2C%22id%22%3A5%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%7B%22table_calculation%22%3A%22q3_2019_count%22%2C%22label%22%3A%22Q3+2019+Count%22%2C%22expression%22%3A%22sum%28pivot_index%28%24%7Borders.count%7D%2C1%29%29%22%2C%22value_format%22%3Anull%2C%22value_format_name%22%3Anull%2C%22_kind_hint%22%3A%22supermeasure%22%2C%22_type_hint%22%3A%22number%22%2C%22is_disabled%22%3Atrue%7D%5D&origin=share-expanded"
# #         url: "https://master.dev.looker.com/explore/danielle_test/order_items?fields=orders.count,orders.status&f[orders.created_date]={{ orders.created_date._value }}&f[orders.created_month]={{ _filters['orders.created_month'] | url_encode }}&f[orders.status]={{ _filters['orders.status'] | url_encode }}&sorts=orders.count+desc&limit=500&column_limit=50&vis=%7B%22value_labels%22%3A%22legend%22%2C%22label_type%22%3A%22labPer%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22y_axes%22%3A%5B%5D%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22normal%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22series_types%22%3A%7B%7D%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22ordinal%22%2C%22x_axis_datetime_label%22%3A%22%25B%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22editable%22%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22column_order%22%3A%5B%22%24%24%24_row_numbers_%24%24%24%22%2C%22users.created_month%22%2C%22Men_calculation_1%22%2C%22Men_orders.count%22%2C%22Women_orders.count%22%2C%22Women_calculation_1%22%5D%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22orders.count%22%3A%7B%22is_active%22%3Afalse%7D%7D%2C%22type%22%3A%22looker_pie%22%2C%22defaults_version%22%3A1%2C%22hidden_fields%22%3Anull%2C%22show_null_points%22%3Atrue%2C%22interpolation%22%3A%22linear%22%7D&toggle%3Dvis"
  # url: "https://master.dev.looker.com/explore/danielle_test/order_items?fields=orders.count,orders.status&f[orders.created_date]={{ orders.created_date._value }}&f[orders.created_month]={{ _filters['orders.created_month'] | url_encode }}&f[orders.status]={{ _filters['orders.status'] | url_encode }}&sorts=orders.count+desc&limit=500&column_limit=50&vis=%7B%22value_labels%22%3A%22legend%22%2C%22label_type%22%3A%22labPer%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22y_axes%22%3A%5B%5D%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22normal%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22series_types%22%3A%7B%7D%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22ordinal%22%2C%22x_axis_datetime_label%22%3A%22%25B%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22editable%22%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22show_sql_query_menu_options%22%3Afalse%2C%22column_order%22%3A%5B%22%24%24%24_row_numbers_%24%24%24%22%2C%22users.created_month%22%2C%22Men_calculation_1%22%2C%22Men_orders.count%22%2C%22Women_orders.count%22%2C%22Women_calculation_1%22%5D%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22series_cell_visualizations%22%3A%7B%22orders.count%22%3A%7B%22is_active%22%3Afalse%7D%7D%2C%22type%22%3A%22looker_pie%22%2C%22defaults_version%22%3A1%2C%22hidden_fields%22%3Anull%2C%22show_null_points%22%3Atrue%2C%22interpolation%22%3A%22linear%22%7D&filter_config=%7B%7D&origin=share-expanded&toggle=dat,vis"
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
