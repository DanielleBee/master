view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: brand_with_html {
    type: string
    sql: CONCAT(${brand}," - ",${item_name}) ;;
    html: <a href="https://google.com/search?q={{brand._value}}" target="_blank" >{{value}}</a> ;;
  }

  dimension: brand_without_html {
    type: string
    sql: CONCAT(${brand}," - ",${item_name}) ;;
    #html: <a href="https://google.com/search?q={{brand._value}}&{{item_name._value}}" target="_blank" >{{value}}</a> ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: department_case_when {
    type: string
    case: {
      when: {
        label: "Women"
        sql: ${department}='Women' ;;
      }
      when: {
        label: "Men"
        sql: ${department}='Men' ;;
      }
      when: {
        label: "Difference"
        sql: 1=1 ;;
      }
    }
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  parameter: select_product_detail {
    description: "Product granularity with parameter set up with allowed values"
    type: unquoted
    default_value: "department_value"
    allowed_value: {
      value: "department_value"
      label: "department_label"
    }
    allowed_value: {
      value: "category_value"
      label: "category_label"
    }
    allowed_value: {
      value: "brand_value"
      label: "brand_label"
    }
  }

  dimension: product_hierarchy {
    label_from_parameter: select_product_detail
    description: "To be used with the Select Product Detail parameter - conditional logic with liquid variables in the sql"
    type: string
    sql:
    {% if select_product_detail._parameter_value == 'department_value' %}
      ${department}
    {% elsif select_product_detail._parameter_value == 'category_value' %}
      ${category}
    {% else %}
      ${brand}
    {% endif %} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
