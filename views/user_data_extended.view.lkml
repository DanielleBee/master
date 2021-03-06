include: "user_data.view.lkml"

view: user_data_extended {
  extends: [user_data]
  sql_table_name: demo_db.users ;;

########## Pasted in dimensions from the users table ###############

  dimension: id {
    primary_key: yes
#     hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [15, 25, 35, 45, 55, 65, 75]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [detail*]
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: ampersand_test_geography {
    type: string
    sql: CONCAT (${city},' & ',${state}) ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [city, users.count, orders.count]
#     link: {
#       label: "Drill Explore"
#       url:"/explore/danielle_test/order_items?fields=users.city,users.count,orders.count&f[users.state]={{ value }}&f[orders.created_year]={{ _filters['orders.created_year'] | url_encode }}"
#     }
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_female_users {
    type: count_distinct
    sql:  ${id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: gender
      value: "f"
    }
  }

  measure: median_age {
    type: number
    sql: ${age} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }

  set: user_data_fields {
    fields: [user_data.max_num_orders, user_data.total_num_orders, user_data.user_id, user_data.count]
  }

}
