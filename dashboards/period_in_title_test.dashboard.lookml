- dashboard: period_in_title_test
  title: Table Next Custom Column Order
  layout: newspaper
  elements:
  - title: Underlying Tile Filtered for all 12 months
    name: Underlying Tile Filtered for all 12 months
    model: danielle_test
    explore: order_items
    type: looker_grid
    fields: [orders.created_month_name, users.gender, orders.count, users.count]
    pivots: [orders.created_month_name]
    fill_fields: [orders.created_month_name]
    sorts: [orders.count desc 10, orders.created_month_name]
    limit: 500
    dynamic_fields: [{table_calculation: orders_mom, label: Orders MoM, expression: "(pivot_index(${orders.count},2)-pivot_index(${orders.count},1))/pivot_index(${orders.count},1)",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
        _type_hint: number}, {table_calculation: users_mom, label: Users MoM, expression: "(pivot_index(${users.count},2)-pivot_index(${users.count},1))/pivot_index(${users.count},1)",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", users.gender, January|FIELD|1_orders.count,
      February|FIELD|2_orders.count, March|FIELD|3_orders.count, April|FIELD|4_orders.count,
      May|FIELD|5_orders.count, June|FIELD|6_orders.count, July|FIELD|7_orders.count,
      August|FIELD|8_orders.count, September|FIELD|9_orders.count, October|FIELD|10_orders.count,
      November|FIELD|11_orders.count, December|FIELD|12_orders.count, orders_mom,
      January|FIELD|1_users.count, February|FIELD|2_users.count, March|FIELD|3_users.count,
      April|FIELD|4_users.count, May|FIELD|5_users.count, June|FIELD|6_users.count,
      July|FIELD|7_users.count, August|FIELD|8_users.count, September|FIELD|9_users.count,
      October|FIELD|10_users.count, November|FIELD|11_users.count, December|FIELD|12_users.count,
      users_mom]
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      orders.count:
        is_active: false
    conditional_formatting: [{type: between, value: [-1, 0], background_color: "#EF5350",
        font_color: !!null '', color_application: {collection_id: b40c75b1-e794-482f-8fb6-9373a0052342,
          palette_id: b5320db1-1662-41cd-8487-43951541af4e, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [orders_mom, users_mom]}, {type: between, value: [
          0, 0.06], background_color: "#d9f5be", font_color: !!null '', color_application: {
          collection_id: b40c75b1-e794-482f-8fb6-9373a0052342, palette_id: b5320db1-1662-41cd-8487-43951541af4e,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [orders_mom, users_mom]},
      {type: greater than, value: 0.06, background_color: "#66BB6A", font_color: !!null '',
        color_application: {collection_id: b40c75b1-e794-482f-8fb6-9373a0052342, palette_id: b5320db1-1662-41cd-8487-43951541af4e,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [orders_mom, users_mom]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Date: orders.created_month
    row: 0
    col: 0
    width: 24
    height: 4
  - title: Underlying Tile Filtered for Nov. and Dec.
    name: Underlying Tile Filtered for Nov. and Dec.
    model: danielle_test
    explore: order_items
    type: looker_grid
    fields: [orders.created_month_name, users.gender, orders.count, users.count]
    pivots: [orders.created_month_name]
    sorts: [orders.created_month_name, orders_mom 0]
    limit: 500
    dynamic_fields: [{table_calculation: orders_mom, label: Orders MoM, expression: "(pivot_index(${orders.count},2)-pivot_index(${orders.count},1))/pivot_index(${orders.count},1)",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
        _type_hint: number}, {table_calculation: users_mom, label: Users MoM, expression: "(pivot_index(${users.count},2)-pivot_index(${users.count},1))/pivot_index(${users.count},1)",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", users.gender, November|FIELD|11_orders.count,
      December|FIELD|12_orders.count, orders_mom, November|FIELD|11_users.count, December|FIELD|12_users.count,
      users_mom]
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      orders.count:
        is_active: false
    conditional_formatting: [{type: between, value: [-1, 0], background_color: "#EF5350",
        font_color: !!null '', color_application: {collection_id: b40c75b1-e794-482f-8fb6-9373a0052342,
          palette_id: b5320db1-1662-41cd-8487-43951541af4e, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [orders_mom, users_mom]}, {type: between, value: [
          0.01, 0.06], background_color: "#d9f5be", font_color: !!null '', color_application: {
          collection_id: b40c75b1-e794-482f-8fb6-9373a0052342, palette_id: b5320db1-1662-41cd-8487-43951541af4e,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [orders_mom, users_mom]},
      {type: greater than, value: 0.06, background_color: "#66BB6A", font_color: !!null '',
        color_application: {collection_id: b40c75b1-e794-482f-8fb6-9373a0052342, palette_id: b5320db1-1662-41cd-8487-43951541af4e,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [orders_mom, users_mom]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Date: orders.created_month
    row: 4
    col: 0
    width: 24
    height: 4
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 5 months ago for 5 months
    allow_multiple_values: true
    required: false
