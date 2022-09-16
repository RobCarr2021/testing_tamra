
# If necessary, uncomment the line below to include explore_source.
# include: "thelook.model.lkml"

view: dt_level_2 {
  derived_table: {
    sql: SELECT
          TRIM(products.category)  AS products_category,
          TRIM(products.department)  AS products_department,
          TRIM(products.brand)  AS products_brand,
          COALESCE(SUM(( order_items.sale_price - inventory_items.cost ) ), 0) AS order_items_total_gross_margin,
          1.0 * ( COALESCE(SUM((order_items.sale_price - inventory_items.cost) ), 0) )/ nullif(( COALESCE(SUM(order_items.sale_price ), 0) ),0)  AS order_items_total_gross_margin_percentage,
          COALESCE(SUM(order_items.sale_price ), 0) AS order_items_total_sale_price
      FROM looker-private-demo.ecomm.order_items  AS order_items
      FULL OUTER JOIN looker-private-demo.ecomm.inventory_items  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
      LEFT JOIN looker-private-demo.ecomm.products  AS products ON products.id = inventory_items.product_id
      GROUP BY ROLLUP(products.category, products.department, products.brand)
      ORDER BY
          4 DESC
      --LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_category {
    type: string
    sql: ${TABLE}.products_category ;;
  }

  dimension: products_department {
    type: string
    sql: ${TABLE}.products_department ;;
  }

  dimension: products_brand {
    type: string
    sql: ${TABLE}.products_brand ;;
  }

  dimension: order_items_total_gross_margin {
    type: number
    sql: ${TABLE}.order_items_total_gross_margin ;;
  }

  dimension: order_items_total_gross_margin_percentage {
    type: number
    sql: ${TABLE}.order_items_total_gross_margin_percentage ;;
  }

  measure: measure_1 {
    type: sum
    sql: ${order_items_total_gross_margin} ;;
    value_format_name: decimal_4
  }

  measure: measure_2 {
    type: sum
    sql: ${order_items_total_sale_price} ;;
    value_format_name: decimal_4
  }

  measure: ratio {
    type: number
    sql: ${measure_1}/nullif(${measure_2},0) ;;
    value_format_name: decimal_4
  }

  dimension: order_items_total_sale_price {
    type: number
    sql: ${TABLE}.order_items_total_sale_price ;;
  }

  set: detail {
    fields: [
      products_category,
      products_department,
      products_brand,
      order_items_total_gross_margin,
      order_items_total_gross_margin_percentage,
      order_items_total_sale_price
    ]
  }
}
