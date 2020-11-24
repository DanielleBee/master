view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

########################## HTML Images ###################################

  dimension: aon_logo {
    type: string
    sql: 1 ;;
    html: <img src="https://cdn.filestackcontent.com/fMVx1x2rQb5oHLv0QA4l" height=60% width=60% /> ;;
  }

dimension: aon_logo_div_tags {
    type: string
    sql: 1 ;;
    html: <div class="single-value"><img src="https://cdn.filestackcontent.com/fMVx1x2rQb5oHLv0QA4l" height=60% width=60% /> </div> ;;
}

dimension: brooklyn_brewery {
  type: string
  sql:  1 ;;
  html: <img src="https://www.miltonglaser.com/thumbs/665x408/files/zc/Brooklynlogo-1088.jpg" height=70% width=70% />  ;;
}
#########################################################################


  dimension: id {
    primary_key: yes
    hidden: yes
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

  dimension: city_user_attribute_test {
    type: string
#     sql:
# #     {% assign user_attribute_test1 %}
# #     {% if user_attribute_test1 %}
# # {{ user_attributes['user_attribute_test1'] }}
# # {% else %} ${city}
# # {% endif %} ;;
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
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: html_test {
    type: string
    sql: {% date_end created_date %} ;;
    html: Latest date as of {{rendered_value}} ;;
  }

  measure: html_test_2 {
    type: date
    sql: max(${created_raw}) ;;
    html: <p style="font-size: 50%">Latest data as of {{rendered_value}}</p> ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
#     can_filter: no
    skip_drill_filter: yes
    sql: ${TABLE}.first_name ;;
    html:
    {% if value == _user_attributes['first_name'] %}
    {{value}}
    {% else %}
    {% endif %};;
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


  measure: dummy {
    hidden: yes
    type: number
    sql: 1=1 ;;
    drill_fields: [city, users.count, orders.count]
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
      link: {
        label: "drill"
        url: "
           {% assign vis= '{\"show_view_names\":false,
\"show_row_numbers\":true,
\"transpose\":false,
\"truncate_text\":true,
\"hide_totals\":false,
\"hide_row_totals\":false,
\"size_to_fit\":true,
\"table_theme\":\"white\",
\"limit_displayed_rows\":false,
\"enable_conditional_formatting\":false,
\"header_text_alignment\":\"left\",
\"header_font_size\":\"12\",
\"rows_font_size\":\"12\",
\"conditional_formatting_include_totals\":false,
\"conditional_formatting_include_nulls\":false,
\"show_sql_query_menu_options\":false,
\"show_totals\":true,
\"show_row_totals\":true,
\"series_cell_visualizations\":{\"users.count\":{\"is_active\":true}},
\"type\":\"looker_grid\",
\"truncate_column_names\":false,
\"defaults_version\":1,
\"series_types\":{}}' %}

          {{ dummy._link }}&vis={{ vis | encode_uri }}"
      }



      #     drill_fields: [city, users.count, orders.count]
#     link: {
#       label: "Drill Explore"
#       url:"/explore/danielle_test/order_items?fields=users.city,users.count,orders.count&f[users.state]={{ value }}&f[orders.created_year]={{ _filters['orders.created_year'] | url_encode }}"
#     }
#     link: {
#       label: "Drill Dashboard"
#       url:"/dashboards/4026?State={{ value | url_encode }}"
#     }
    # html:
    # {% if {{_user_attributes['danielle_test']}} == "embed_user"  %}
    #     <a href="/embed/dashboards-next/4026?State={{ value }}">{{value}}</a>
    #   {% elsif {{_user_attributes['danielle_test']}} == "user" %}
    #     <a href="/embed/dashboards-next/4026?State={{ value }}">{{value}}</a>
    #   {% else %}
    #     <a href="/embed/dashboards-next/4026?State={{ value }}">{{value}}</a>
    #   {% endif %};;
    }

  dimension: region {
    type: string
    sql: case when users.state in ("Maine", "Massachusetts", "Connecticut", "Vermont","Rhode Island","New Hampshire") then "New England"
    when users.state in ("Washington", "Oregon") then "Pacific Northwest"
    when users.state in ("Florida", "Alabama", "Mississippi", "South Carolina", "Georgia", "Louisiana") then "South"
    when users.state in ("Arizona", "New Mexico", "Nevada") then "Southwest"
    else "No Region Assigned"
    end;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
#     html: {{ users.state._rendered_value }} ;;
  }

  dimension: city_state_zip {
    type: string
    sql: concat(${city},", ",${state}, ": ", ${zip}) ;;
  }

  measure: count {
    label: "User Count"
    type: count
    drill_fields: [detail*]
    link: {
      label: "drill test"
      url: "
      {% assign vis= '{\"show_view_names\":false,
\"show_row_numbers\":true,
\"transpose\":false,
\"truncate_text\":true,
\"hide_totals\":false,
\"hide_row_totals\":false,
\"size_to_fit\":true,
\"table_theme\":\"white\",
\"limit_displayed_rows\":false,
\"enable_conditional_formatting\":false,
\"header_text_alignment\":\"left\",
\"header_font_size\":12,
\"rows_font_size\":12,
\"conditional_formatting_include_totals\":false,
\"conditional_formatting_include_nulls\":false,
\"type\":\"looker_grid\",
\"defaults_version\":1}' %}

{{link}}&f[users.state]=&vis={{vis | encode_uri}}"
    }
  }

  measure: count_html_drill {
    type: count
    drill_fields: [detail*]
#     html: <a href="{{link}}&sorts=users.last_name+desc"target="_self"> {{rendered_value}} </a> ;;
      link: {
        label: "drill"
        url: "{{link}}&sorts=users.last_name+asc"
      }
  }

#   target="_self"

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
    type: median
    sql: ${age} ;;
  }

  measure: 25_percentile_age {
    type: percentile
    percentile: 25
    sql: ${age} ;;
  }

  measure: 75_percentile_age {
    type: percentile
    percentile: 75
    sql: ${age} ;;
  }

  measure: min_age {
    type: min
    sql: ${age} ;;
  }

  measure: max_age {
    type: max
    sql: ${age} ;;
  }

  measure: count_cities {
    type: count_distinct
    sql: ${city} ;;
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
}
