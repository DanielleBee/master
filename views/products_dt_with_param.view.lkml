view: products_dt_with_param {
    derived_table: {
    sql:
    SELECT ({% if products.select_product_detail._parameter_value == 'department_value' %}
      products.department
    {% elsif products.select_product_detail._parameter_value == 'category_value' %}
      products.category
    {% else %}
      products.brand
    {% endif %}) AS `product_level`,
    COUNT(DISTINCT products.id) AS `product_count`
    FROM demo_db.products
    GROUP BY 1
    ORDER BY COUNT(DISTINCT products.id ) DESC;;
}

# SELECT

#             products.category
#             AS `products.product_hierarchy`,
#         COUNT(DISTINCT products.id ) AS `products.count`
#       FROM demo_db.order_items  AS order_items
#       LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
#       LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

#       GROUP BY 1
#       ORDER BY COUNT(DISTINCT products.id ) DESC
#       LIMIT 500
#       ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: select_product_detail{
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

  dimension: product_level {
    type: string
    sql: ${TABLE}.`product_level` ;;
  }

  dimension: products_count {
    type: number
    sql: ${TABLE}.`product_count` ;;
  }

  set: detail {
    fields: [product_level, products_count]
  }
}
