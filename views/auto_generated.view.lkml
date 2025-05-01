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