
  test: counts_by_age_tier {
    explore_source: order_items {
      column: age_tier { field: users.age_tier }
      column: order_items_count { field: order_items.counttest }
      column: orders_count { field: orders.count }
      filters: {
        field: orders.created_year
        value: "2018"
      }
    }

    assert: order_items_counttest_is_positive {
      expression: ${order_items.counttest} > 0 ;;
    }

    assert: orders_count_is_positive {
      expression: ${orders.count} > 0 ;;
    }

    assert: order_items_greater_than_orders {
      expression: ${order_items.counttest} >= ${orders.count} ;;
    }
  }
