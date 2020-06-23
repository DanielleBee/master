view: orders_by_date_dt2 {
  derived_table: {
    sql: SELECT t2.created_at,
              count(t2.id) as t2_number
              FROM demo_db.orders as t2

              group by 1
              ORDER BY 1 DESC
               ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: t2_number {
    type: number
    sql: ${TABLE}.t1_number ;;
  }

  set: detail {
    fields: [created_at_time, t2_number]
  }
}
