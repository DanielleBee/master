view: products_dt_capitalization {
    derived_table: {
      sql: -- Did not use order_items::rollup__orders_created_date__orders_status; it does not include the following fields in the query: products.category_capitalization_differences, products.category, orders.count
              SELECT
                  case when products.category = "Leggings" then "pants"
                  when products.category = "Accessories" then "accessories"
                  when products.category = "Skirts" then "socks"
                  when products.category = "Plus" then "jeans-hi"
                  when products.category = "Maternity" then "pants"
                  when products.category = "Swim" then null
                  when products.category = "Shorts" then "jeans"
                  else products.category
                  end AS `products.category_capitalization_differences`,
                  products.category  AS `products.category`,
                  products.department AS `products.department`,
                  COUNT(DISTINCT orders.id ) AS `orders.count`
              FROM demo_db.order_items  AS order_items
              LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
              LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
              LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
              GROUP BY
                  1,
                  2
              ORDER BY
                  case when products.category = "Leggings" then "pants"
                  when products.category = "Accessories" then "accessories"
                  when products.category = "Skirts" then "socks"
                  when products.category = "Plus" then "jeans-hi"
                  when products.category = "Maternity" then "pants"
                  when products.category = "Swim" then null
                  when products.category = "Shorts" then "jeans"
                  else products.category
                  end
              LIMIT 500
              ;;
      #         indexes: ["products_category_capitalization_differences"]
      # persist_for: "24 hours"
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: products_category_capitalization_differences {
      type: string
      sql: ${TABLE}.`products.category_capitalization_differences` ;;
    }

    dimension: products_category {
      type: string
      sql: ${TABLE}.`products.category` ;;
    }

    dimension: products_department {
      type: string
      sql: ${TABLE}.`products.department` ;;
    }

    dimension: orders_count {
      type: number
      sql: ${TABLE}.`orders.count` ;;
    }

    set: detail {
      fields: [products_category_capitalization_differences, products_category, orders_count]
    }
    }
