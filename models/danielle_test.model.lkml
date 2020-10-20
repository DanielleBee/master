connection: "thelook"

include: "/views/**/*.view"
include: "/dashboards/**/*.dashboard"

include: "/Datatests/data_test.lkml"
include: "/Datatests/data_test_primary_key.lkml"

# datagroup: danielle_test_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }

datagroup: danielle_datagroup_test {
  sql_trigger: SELECT MAX(current_hour) FROM sandbox_scratch.LB_danielle_test_current_hour;;
  max_cache_age: "0 seconds"
}

datagroup: danielle_every_hour {
  sql_trigger: SELECT FLOOR(UNIX_TIMESTAMP() / (1*60*60)) ;;
}

# persist_with: danielle_test_default_datagroup

# Place in `danielle_test` model
explore: +order_items {
  aggregate_table: rollup__orders_created_date__orders_status {
    query: {
      dimensions: [orders.created_date, orders.status]
      measures: [sum_sale_price_type_number]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }
}

explore: connection_reg_r3 {}

explore: derived_test_table_3_20190510 {}

explore: non_window_function_dt {}

# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: inventory_items {
#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: products_dt_with_param {
#   join: products {
#     type: left_outer
#     sql_on: ${products_dt_with_param.product_level} = ${products.product_hierarchy} ;;
#     relationship: one_to_many
#   }
# }

explore: orders_by_date_dt {
  join: orders {
    type: left_outer
    sql_on: ${orders_by_date_dt.created_at_date} = ${orders.created_date} ;;
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

# explore: products {
# }

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

explore: orders_by_date_dt2 {}

explore: current_hour {}
