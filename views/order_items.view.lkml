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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
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
  }

  measure: total_sale_price {
    type:  sum
    sql: ${sale_price} ;;
    value_format_name: usd
#       value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0.00"
  }

  measure: total_sale_price_html {
    label: " "
    type: sum
    sql: ${sale_price} ;;
    html: {{ orders.ampersand_test_status._rendered_value }}: Total Price {{ rendered_value }} ;;
  }

  measure:  percent_of_total_test {
    type: percent_of_total
    direction: "column"
    value_format_name: decimal_1
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
    drill_fields: [id, orders.id, inventory_items.id]
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
    sql: CASE(${returned_date} IS NOT NULL THEN ${orders.created_date}-${returned_date} ELSE "N/A" END) ;;
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
}
