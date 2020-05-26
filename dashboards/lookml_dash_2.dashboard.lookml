# - dashboard: lookml_dash_2
#   title: lookml dash test
#   layout: newspaper
#   elements:
#   - title: this. tile. has. periods. in. the. title.
#     name: this. tile. has. periods. in. the. title.
#     model: danielle_test
#     explore: order_items
#     type: looker_grid
#     fields: [order_items.dynamic_metric, order_items.total_sale_price_html_2, orders.created_year,
#       orders.created_month_name]
#     pivots: [orders.created_year]
#     filters:
#       order_items.metric_selector: total^_sale^_price
#       orders.created_year: 3 years
#     sorts: [orders.created_year 0, orders.created_month_name]
#     limit: 500
#     total: true
#     query_timezone: America/Los_Angeles
#     show_view_names: false
#     show_row_numbers: true
#     transpose: false
#     truncate_text: true
#     hide_totals: false
#     hide_row_totals: false
#     size_to_fit: true
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     header_text_alignment: left
#     header_font_size: '12'
#     rows_font_size: '12'
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     show_sql_query_menu_options: false
#     show_totals: true
#     show_row_totals: true
#     series_cell_visualizations:
#       order_items.dynamic_metric:
#         is_active: false
#     hidden_fields: []
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     plot_size_by_field: false
#     trellis: ''
#     stacking: ''
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     listen: {}
#     row: 0
#     col: 0
#     width: 24
#     height: 5
#   - title: This One Does Too.
#     name: This One Does Too.
#     model: danielle_test
#     explore: order_items
#     type: looker_grid
#     fields: [order_items.dynamic_metric, order_items.total_sale_price_html_2, orders.created_year,
#       orders.created_month_name]
#     pivots: [orders.created_year]
#     filters:
#       order_items.metric_selector: total^_sale^_price
#       orders.created_year: 3 years
#     sorts: [orders.created_year 0, orders.created_month_name]
#     limit: 500
#     total: true
#     query_timezone: America/Los_Angeles
#     show_view_names: false
#     show_row_numbers: true
#     transpose: false
#     truncate_text: true
#     hide_totals: false
#     hide_row_totals: false
#     size_to_fit: true
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     header_text_alignment: left
#     header_font_size: '12'
#     rows_font_size: '12'
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     show_sql_query_menu_options: false
#     show_totals: true
#     show_row_totals: true
#     series_cell_visualizations:
#       order_items.dynamic_metric:
#         is_active: false
#     hidden_fields: []
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     plot_size_by_field: false
#     trellis: ''
#     stacking: ''
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     listen: {}
#     row: 5
#     col: 0
#     width: 24
#     height: 5
#   - title: Order Count - 2018 vs 2019 (no periods)
#     name: Order Count - 2018 vs 2019 (no periods)
#     model: danielle_test
#     explore: order_items
#     type: looker_grid
#     fields: [orders.created_year, orders.created_month_name, orders.count]
#     pivots: [orders.created_year]
#     filters:
#       order_items.metric_selector: total^_sale^_price
#       orders.created_year: 3 years
#     sorts: [orders.created_year 0, orders.created_month_name]
#     limit: 500
#     total: true
#     query_timezone: America/Los_Angeles
#     show_view_names: false
#     show_row_numbers: true
#     transpose: false
#     truncate_text: true
#     hide_totals: false
#     hide_row_totals: false
#     size_to_fit: true
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     header_text_alignment: left
#     header_font_size: '12'
#     rows_font_size: '12'
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     show_sql_query_menu_options: false
#     show_totals: true
#     show_row_totals: true
#     series_cell_visualizations:
#       order_items.dynamic_metric:
#         is_active: false
#     hidden_fields: []
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     plot_size_by_field: false
#     trellis: ''
#     stacking: ''
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     listen: {}
#     row: 10
#     col: 0
#     width: 24
#     height: 5
