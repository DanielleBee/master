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
    type: yesno
    sql: ${sale_price}>=1000 ;;
  }

  dimension: is_medium_order {
    type: yesno
    sql: ${sale_price}<1000 AND ${sale_price} >=500;;
  }

  dimension: is_small_order {
    type: yesno
    sql: ${sale_price}<500;;
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
    html:
    {% if _user_attributes['last_name'] == "Behette" %} <a href = "{{order_items.count._link}}">{{rendered_value}}</a>
{% elsif _user_attributes['last_name'] == "Hicks" %} <a href = "{{order_items.average_sale_price._link}}">{{rendered_value}}</a>
{% endif %} ;;
  }

  measure: total_sale_price {
    type:  sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
#       value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0.00"
  }

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
    type: number
    sql: SUM(CASE WHEN ${is_big_order} THEN 2 ELSE 1 END) ;;
  }

  set: drill_set {
   fields: [order_id, order_size, products.category, count]
  }
}
