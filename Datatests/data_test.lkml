
  test: quantities_by_age_tier {
    explore_source: order_items {
      column: age_tier { field: users.age_tier }
      column: order_items_count { field: order_items.counttest }
      column: orders_count { field: orders.count }
      filters: {
        field: orders.created_year
        value: "2018"
      }
    }

    assert: quantities_are_positive {
      expression: ${order_items.counttest} > 0 ;;
    }

    assert: trans_are_positive {
      expression: ${orders.count} > 0 ;;
    }

    assert: qty_over_trans {
      expression: ${order_items.counttest} >= ${orders.count} ;;
    }
  }
