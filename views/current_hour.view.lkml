view: current_hour {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: danielle_every_hour
    sql: SELECT HOUR(NOW())
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hournow {
    type: number
    sql: ${TABLE}.`HOUR(NOW())` ;;
  }

  set: detail {
    fields: [hournow]
  }
}
