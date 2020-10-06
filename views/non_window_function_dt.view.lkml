view: non_window_function_dt {
  derived_table: {
    sql: SELECT
        users.state  AS `users.state`,
        users.city  AS `users.city`,
        COUNT(*) AS `orders.count`
      FROM demo_db.orders  AS orders
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      GROUP BY 1,2
      ORDER BY COUNT(*) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_state {
    type: string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: users_city {
    type: string
    sql: ${TABLE}.`users.city` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  measure: count_filtered {
    type: count_distinct
    sql: ${users_city} ;;
    filters: [orders_count: ">200"]
  }

  measure: count_filtered2 {
    type: count_distinct
    sql: ${orders_count} ;;
    filters: [orders_count: ">200"]
  }

  set: detail {
    fields: [users_state, users_city, orders_count]
  }
}
