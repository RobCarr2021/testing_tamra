view: category_order_facts {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand}
      column: category { field: products.category }
      column: count {}
      column: order_count {}
      column: total_sale_price {}
    }
    persist_for: "24 hours"
  }

}


# NDT1: “Revenue per day”
# orders.created_date, orders.sum_revenue (one dimension, one measure)
# NDT2: “Revenue per day and user”
# orders.created_date, users.full_name, orders.sum_revenue (two dimensions, one measure)
# NDT3: “Revenue and order count per hour and department”
# orders.created_hour, skus.department, orders.sum_revenue, orders.count (two dimensions, two measures)

# The following queries will be routed as follows:
# “Revenue per day” => NDT1
# “Revenue per month” => NDT1
# “Order count per day” => NDT3
# “Revenue per hour” => NDT3
# “Revenue per user” => NDT2
# “Revenue per month and department” => NDT3
# “Revenue per hour and user” => no valid NDT
# “Order count per user” => no valid NDT
# “Profit per day” => no valid NDT
