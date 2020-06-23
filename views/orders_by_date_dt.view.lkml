view: orders_by_date_dt {
    derived_table: {
      sql: SELECT t1.created_at,
              count(t1.id) as t1_number
              FROM demo_db.orders as t1

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

    dimension: t1_number {
      type: number
      sql: ${TABLE}.t1_number ;;
    }

    set: detail {
      fields: [created_at_time, t1_number]
    }
  }
