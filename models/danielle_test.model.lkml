connection: "thelook"

include: "/views/**/*.view"
# include: "/dashboards/**/*.dashboard"

include: "/Datatests/data_test.lkml"
include: "/Datatests/data_test_primary_key.lkml"

datagroup: danielle_test_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: danielle_test_default_datagroup

explore: connection_reg_r3 {}

explore: derived_test_table_3_20190510 {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  # sql_always_where: {% condition orders.date_granularity %} orders.created_at {% endcondition %} ;;
##### For use with the parameter type: string
#   sql_always_where:  {% if orders.date_picker._parameter_value == "'Last Month'" %}
#   ((( orders.created_at ) >= ((DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-%m-01')),INTERVAL -1 month))) AND ( orders.created_at ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-%m-01')),INTERVAL -1 month),INTERVAL 1 month)))))
#   {% elsif orders.date_picker._parameter_value == "'This Year'" %}
#   ((( orders.created_at ) >= ((TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-01-01')))) AND ( orders.created_at ) < ((DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-01-01')),INTERVAL 1 year)))))
#   {% elsif orders.date_picker._parameter_value == "'Last Year'" %}
#   ((( orders.created_at ) >= ((DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-01-01')),INTERVAL -1 year))) AND ( orders.created_at ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(NOW()),'%Y-01-01')),INTERVAL -1 year),INTERVAL 1 year)))))
#   {% else %}
#   1=1
#   {% endif %} ;;
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: derived_table {
  join: orders {
    type: left_outer
    sql_on: ${derived_table.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

explore: user_data_extended {
  fields: [ALL_FIELDS*, - user_data_extended.user_data_fields*]
}

explore: zozo_table_20190507 {}

explore: zozo_table_20190508 {}

explore: zozo_table_null {}
