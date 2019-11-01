view: products {
  sql_table_name: products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: category {
    sql: TRIM(${TABLE}.category) ;;
    drill_fields: [item_name]
  }

  dimension: item_name {
    sql: TRIM(${TABLE}.name) ;;
  }

  dimension: brand {
    sql: TRIM(${TABLE}.brand) ;;

    link: {
      label: "Website"
      url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
    }

    link: {
      label: "Facebook"
      url: "http://www.google.com/search?q=site:facebook.com+{{ value | encode_uri }}+clothes&btnI"
      icon_url: "data:image/png;base64,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"
    }

    link: {
      label: "{{value}} Analytics Dashboard"
      url: "/dashboards/thelook::brand_analytics?Brand%20Name={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }

    drill_fields: [category, item_name]
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: department {
    sql: TRIM(${TABLE}.department) ;;
  }

  dimension: sku {
    sql: ${TABLE}.sku ;;
  }

  dimension: distribution_center_id {
    type: number
    sql: ${TABLE}.distribution_center_id ;;
  }

  ## MEASURES ##

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: brand_count {
    type: count_distinct
    sql: ${brand} ;;
    drill_fields: [brand, detail2*, -brand_count] # show the brand, a bunch of counts (see the set below), don't show the brand count, because it will always be 1
  }

  measure: category_count {
    alias: [category.count]
    type: count_distinct
    sql: ${category} ;;
    drill_fields: [category, detail2*, -category_count] # don't show because it will always be 1
  }

  measure: department_count {
    alias: [department.count]
    type: count_distinct
    sql: ${department} ;;
    drill_fields: [department, detail2*, -department_count] # don't show because it will always be 1
  }

  set: detail {
    fields: [id, item_name, brand, category, department, retail_price, customers.count, orders.count, order_items.count, inventory_items.count]
  }

  set: detail2 {
    fields: [category_count, brand_count, department_count, count, customers.count, orders.count, order_items.count, inventory_items.count, products.count]
  }
}
