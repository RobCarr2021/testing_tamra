connection: "rob_argolis"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: elevate_nested_data {
  label: "Customers & Addresses"
  view_label: "Customer"
  hidden: no
  join: elevate_nested_data__address {
    view_label: "Address"
    sql: LEFT JOIN UNNEST(${elevate_nested_data.address}) as elevate_nested_data__address ;;
    relationship: one_to_many
  }
}

explore: json_data {
  label: "Orders and Locations"
  view_label: "Order Items"
  join: cart {
    view_label: "Cart Items"
    sql: LEFT JOIN UNNEST(JSON_EXTRACT_ARRAY(${json_data.cart})) as cart ;;
    relationship: one_to_many
  }
  join: former_locations {
    view_label: "Location"
    sql: LEFT JOIN UNNEST(JSON_EXTRACT_ARRAY(${json_data.former_locations})) as former_locations ;;
    relationship: one_to_many
  }
}
