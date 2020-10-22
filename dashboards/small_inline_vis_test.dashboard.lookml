- dashboard: small_inline_vis_test
  title: Small Inline Vis Test Dash
  layout: newspaper
  elements:
  - title: Table Legacy, One Pivot
    name: Table Legacy, One Pivot
    model: danielle_test
    explore: order_items
    type: table
    fields: [orders.created_date, products.category, order_items.count]
    pivots: [products.category]
    sorts: [orders.created_date desc, products.category]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Date: orders.created_date
    row: 0
    col: 0
    width: 24
    height: 14
  - title: Table Next No Pivots
    name: Table Next No Pivots
    model: danielle_test
    explore: order_items
    type: looker_grid
    fields: [products.category, products.department, orders.status, users.country,
      products.count, users.count, order_items.average_sale_price]
    filters:
      products.department: Women
      orders.status: Complete
      users.country: US
    sorts: [products.category, products.department, orders.status, products.count
        desc]
    subtotals: [products.category, products.department, orders.status]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: true
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_column_widths:
      products.count: 132
      users.count: 164
      order_items.average_sale_price: 198
    series_cell_visualizations:
      products.count:
        is_active: false
    series_text_format:
      order_items.average_sale_price:
        bg_color: "#C2DD67"
    conditional_formatting: []
    hidden_fields: [users.country, products.department, orders.status]
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
      Date: orders.created_date
    row: 14
    col: 0
    width: 24
    height: 14
  - title: Table Legacy, One Pivot, Three Measures
    name: Table Legacy, One Pivot, Three Measures
    model: danielle_test
    explore: order_items
    type: table
    fields: [orders.created_date, products.count, order_items.count, order_items.average_sale_price,
      products.category]
    pivots: [products.category]
    sorts: [orders.created_date desc, products.category]
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          custom: {id: bd7bfc33-e140-bb95-9035-4f98cce6777b, label: Custom, type: continuous,
            stops: [{color: "#08b211", offset: 0}, {color: "#ede838", offset: 50},
              {color: "#bf150c", offset: 100}]}, options: {steps: 5, constraints: {
              mid: {type: percentile, value: 92}}, mirror: true}}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 30,
        background_color: '', font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [products.count]}, {type: equal to, value: 0,
        background_color: "#22c23f", font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    listen:
      Date: orders.created_date
    row: 28
    col: 0
    width: 24
    height: 16
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 2019/12/01 to 2019/12/21
    allow_multiple_values: true
    required: false
    model: danielle_test
    explore: order_items
    listens_to_filters: []
    field: orders.created_date
