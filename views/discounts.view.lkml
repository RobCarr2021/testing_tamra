view: discounts {
  sql_table_name: looker-private-demo.ecomm.discounts;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: discount_price {
    type: number
    sql: ${TABLE}.discount_price ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date ;;
  }

  set: detail {
    fields: [
      product_id,
      inventory_item_id,
      retail_price,
      discount_price,
      discount_amount,
      date_time
    ]
  }
}
