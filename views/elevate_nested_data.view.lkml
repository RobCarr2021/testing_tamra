# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
# explore: elevate_nested_data {
#   hidden: yes
#     join: elevate_nested_data__address {
#       view_label: "Elevate Nested Data: Address"
#       sql: LEFT JOIN UNNEST(${elevate_nested_data.address}) as elevate_nested_data__address ;;
#       relationship: one_to_many
#     }
# }
view: elevate_nested_data {
  sql_table_name: `firstproject-352109.elevate.elevate_nested_data` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }
  dimension: names__first_name {
    type: string
    sql: ${TABLE}.names.first_name ;;
    group_label: "Names"
    group_item_label: "First Name"
  }
  dimension: names__last_name {
    type: string
    sql: ${TABLE}.names.last_name ;;
    group_label: "Names"
    group_item_label: "Last Name"
  }
  measure: count {
    type: count
    drill_fields: [id, names__last_name, names__first_name]
  }
}

view: elevate_nested_data__address {

  dimension: city {
    type: string
    sql: city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: country ;;
  }
  dimension: elevate_nested_data__address {
    type: string
    hidden: yes
    sql: elevate_nested_data__address ;;
  }
  dimension: state {
    type: string
    sql: state ;;
  }
  dimension: status {
    type: string
    sql: status ;;
  }
}
