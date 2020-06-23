view: orders_by_date_dt {
    derived_table: {
      publish_as_db_view: yes
      sql: SELECT
              t1.id,
              t1.created_at,
              count(t1.id) as total_count
              FROM demo_db.orders as t1

              group by 1, 2
              ORDER BY 2 DESC
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

    dimension: total_count {
      type: number
      sql: ${TABLE}.total_count ;;
    }

    set: detail {
      fields: [created_at_time, total_count]
    }
  }
