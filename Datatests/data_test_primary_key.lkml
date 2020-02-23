
test: primary_key_valid {
  explore_source: order_items {
    column: order_items_count { field: order_items.count }
    column: orders_items_count_distinct { field: order_items.count_distinct }
  }

  assert: distinct_values {
    expression: ${order_items.count} = ${order_items.count_distinct} ;;
  }

  assert: order_items_count_greater_than_40000 {
    expression: ${order_items.count} >= 40000 ;;
  }
}

test: order_item_id_is_unique {
  explore_source: order_items {
    column: id {}
    column: count {}
    sort: {
      field: count
      desc: yes
    }
    limit: 1
  }
  assert: order_item_id_is_unique {
    expression: ${order_items.count} = 1 ;;
  }
}

test: primary_key_is_not_null {
  explore_source: order_items {
    column: order_item_id {field: order_items.id}
    sort: {
      field: order_item_id
      desc: yes
    }
    limit: 1
  }
  assert: order_item_id_is_not_null {
    expression: NOT is_null(${order_items.id}) ;;
  }
}



######
# test: primary_key_valid2 {
#   explore_source: order_items {
#     column: order_item_id { field: order_items.id }
#     column: order_items_count { field: order_items.count }
#     column: orders_items_count_distinct { field: order_items.count_distinct }
#   }
#
#   assert: primary_key_not_null {
#     expression: NOT is_null(${order_items.id}) ;;
#   }
#
#   assert: distinct_values {
#     expression: count(${order_items.id}) = count_distinct(${order_items.id}) ;;
#   }
#
#   assert: order_items_greater_than_40000 {
#     expression: count(${order_items.id}) >= 40000 ;;
#   }
# }


# test: primary_key_valid3 {
#   explore_source: order_items {
#     column: order_items_count { field: order_items.count }
#   }
#
#   assert: order_items_greater_than_5001 {
#     expression: ${order_items.count} >= 5001 ;;
#   }
# }
