view: cart {

  dimension: item {
    type: string  // Adjust type if needed (e.g., number, date)
    sql: JSON_VALUE(cart, '$.item') ;;
  }

  dimension: item_id {
    type: string  // Adjust type if needed (e.g., number, date)
    sql: JSON_VALUE(cart, '$.item_id') ;;
  }

}