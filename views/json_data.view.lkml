view: json_data {
  sql_table_name: `firstproject-352109.elevate.json_data` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: cart {
    hidden: yes
    type: string
    sql: ${TABLE}.cart ;;
  }
  dimension: location {
    hidden: yes
    type: string
    sql: ${TABLE}.location ;;
  }
  dimension: former_locations {
    hidden: yes
    type: string
    sql: ${TABLE}.location.former_locations ;;
  }
  dimension: first_state {
    type: string
    sql: JSON_VALUE(location, '$.former_locations[0].state') ;;
  }
  dimension: state {
    type: string
    sql: JSON_VALUE(location, '$.state') ;;
  }
  dimension: street {
    type: string
    sql: JSON_VALUE(location, '$.street') ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: cart {

  dimension: item {
    type: string
    sql: JSON_VALUE(cart, '$.item') ;;
  }
  dimension: item_id {
    type: string
    sql: JSON_VALUE(cart, '$.item_id') ;;
  }
}

view: former_locations {

  dimension: state {
    type: string
    sql: JSON_VALUE(former_locations, '$.state') ;;
  }
  dimension: street {
    type: string
    sql: JSON_VALUE(former_locations, '$.street') ;;
  }
}
