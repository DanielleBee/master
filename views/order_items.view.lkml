view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  filter: returned_date_filter {
    type: date
  }

  dimension: returned_is_not_null {
    type: yesno
    sql: ${returned_date} is not null ;;
  }

  dimension_group: returned {
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
#     convert_tz: no
#     sql: CONVERT_TZ(${TABLE}.returned_at,'+00:00','-05:00') ;;
sql:${TABLE}.returned_at  ;;
drill_fields: []
  }


  dimension_group: duration_test {
    type: duration
    intervals: [day,second]
    sql_start: ${orders.created_raw} ;;
    sql_end: ${returned_raw} ;;
  }

  measure: average_duration {
    type: average
    sql: ${seconds_duration_test};;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: sale_price_negative {
    type: number
    sql: ${TABLE}.sale_price * -1 ;;
  }

  dimension: sale_price_times_1000 {
    type: number
    sql: ${TABLE}.sale_price * 10 ;;
#     value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";[>=100]0.00;[<=-1000000]0.00,,\"M\";[<=-1000]0.00,\"K\";0.00"
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0.00"
#     value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0"
 }


  dimension: sale_price_tier {
    type: tier
    tiers: [50, 100, 150, 200]
    style: integer
    sql: ${sale_price} ;;
    value_format_name:  usd_0
  }

  dimension: is_big_order {
    group_label: "Order Size"
    type: yesno
    sql: ${sale_price}>=500 ;;
  }

  dimension: is_medium_order {
    group_label: "Order Size"
    type: yesno
    sql: ${sale_price}< 500 AND ${sale_price} >=100;;
  }

  dimension: is_small_order {
    group_label: "Order Size"
    type: yesno
    sql: ${sale_price}<100;;
  }

  dimension: order_size {
    type: string
    sql: CASE WHEN ${is_big_order} THEN 'big'
    WHEN  ${is_medium_order} THEN 'medium'
    ELSE 'small'
    END;;
  }

  measure: average_sale_price {
    type:  average
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [order_items.id, order_items.order_size, order_items.sale_price_tier]
#     html:
#     {% if _user_attributes['last_name'] == "Behette" %} <a href = "{{order_items.count._link}}">{{rendered_value}}</a>
# {% elsif _user_attributes['last_name'] == "Hicks" %} <a href = "{{order_items.average_sale_price._link}}">{{rendered_value}}</a>
# {% endif %} ;;
  }

  measure: avg_sale_price_with_zeros {
    type: average
    sql: case when ${sale_price} < 10 then ${sale_price}-${sale_price} else ${sale_price} end ;;
  }

  measure: avg_sale_price_more_than_10 {
    type: average
    sql: ${sale_price} > 10 ;;
  }

  dimension: sale_price_more_than_10 {
    type: yesno
    sql: ${sale_price} > 10 ;;
  }

  measure: average_sale_price_yesno {
    type: average
    sql: ${sale_price} ;;
    # filters: [sale_price_more_than_10: "yes"]
    filters: [sale_price: ">10"]
  }

  measure: total_sale_price {
    type:  sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
#       value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0.00"
  }

  measure: total_sale_price_html_param {
    type:  sum
    sql: ${sale_price} ;;
    value_format_name: decimal_2
    html: <a href="{{link}}"> €{{rendered_value}} </a> ;;
    drill_fields: [drill_set*]
  }

  measure: total_sale_price_html_param_2 {
    type:  sum
    sql: ${sale_price} ;;
    value_format_name: decimal_2
    html: <a href="{{link}}"> {{rendered_value}} EUR </a> ;;
    drill_fields: [drill_set*]
  }

## agg awareness measures type:number testing
  measure: sum_sale_price_type_number {
    type: number
    sql: sum(${sale_price}) ;;
  }

  measure: count_sale_price_type_number {
    type: number
    sql: count(${sale_price}) ;;
  }

  measure: reference_sums_and_divide {
    type: number
    sql: 1.0*${total_sale_price}/nullif(${total_sale_price},${total_sale_price}+2) ;;
  }
###############



######## Dynamic Measure with Parameters ############

  parameter: metric_selector {
    label: "metric_selector"
    type: string
    allowed_value: {
      label: "total_sale_price"
      value: "total_sale_price"
   }
    allowed_value: {
      label: "total_number_of_orders"
      value: "total_number_of_orders"
    }
    allowed_value: {
      label: "average_sale_price_per_order"
      value: "average_sale_price_per_order"
    }
    default_value: "total_sale_price"
  }

  measure: dynamic_metric {
    label_from_parameter: metric_selector
    type: number
    sql:
      {% if metric_selector._parameter_value == "'total_sale_price'" %}
      ${order_items.total_sale_price}
      {% else %}
      ${orders.count}
      {% endif %};;
    html: {% if metric_selector._parameter_value == "'total_number_of_orders'" %}
      {{ orders.count._rendered_value }}
    {% else %}
      {{ total_sale_price._rendered_value }}
    {% endif %}  ;;
  }

######### End Dynamic Measure ##########

  measure: total_sale_price_html_2 {
    type: number
    sql: ${total_sale_price};;
    html:{{ total_sale_price._rendered_value }};;
  }

  measure: total_sale_price_html {
    type: sum
    sql: ${sale_price} ;;
    html: {{ orders.ampersand_test_status._rendered_value }}: Total Price {{ rendered_value }} ;;
  }

  measure: total_sale_price_case_when {
    type: sum
    sql: case when ${order_items.returned_date} > ${orders.created_date}
    then ${sale_price} else 0 end ;;
    value_format_name: usd_0
    drill_fields: [drill_set*]
  }

  measure:  percent_of_total_test {
    type: percent_of_total
    direction: "column"
    value_format_name: decimal_2
    sql: CASE WHEN ${orders.status} = 'cancelled' THEN 0
              WHEN ${orders.status} = 'pending' THEN 0
              ELSE ${total_sale_price} END ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: count_distinct {
    type: count_distinct
    sql: ${id} ;;
#     drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: counttest {
    type: number
    sql:
    {% if _model._name == 'daniellebugtest' %}
    CASE WHEN ${count} = 3276 THEN ${count}*-1 ELSE ${count} END
    {% else %} ${count} {% endif %}
    ;;
  }

  measure: days_between_order_and_return {
    type:  number
    sql: CASE (${returned_date} IS NOT NULL THEN ${orders.created_date}-${returned_date} ELSE "N/A" END) ;;
  }

  measure: largest_order {
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: total_boxes_needed {
    description: "big box"
    type: number
    sql: SUM(CASE WHEN ${is_big_order} THEN 2 ELSE 1 END) ;;
  }

  measure: count_big_orders_yes {
    type: count
    filters: [is_big_order: "yes"]
  }

  measure: big_orders_yes {
    type: yesno
    sql: ${total_sale_price}>=500 ;;
  }

  set: drill_set {
   fields: [order_id, order_size, products.category, count]
  }
}
