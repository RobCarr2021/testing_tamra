
view: std_dev {
  derived_table: {
    sql: with per_hour_per_week_sales AS (


SELECT
    (FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(order_items.created_at , WEEK(MONDAY)))) AS order_items_created_week,
        (EXTRACT(HOUR FROM order_items.created_at )) AS order_items_created_hour_of_day,
    COALESCE(SUM(order_items.sale_price), 0) AS order_items_total_sale_price
FROM looker-private-demo.ecomm.order_items  AS order_items
WHERE ((( order_items.created_at  ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), WEEK(MONDAY)), INTERVAL (-15 * 7) DAY))) AND ( order_items.created_at  ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), WEEK(MONDAY)), INTERVAL (-15 * 7) DAY), INTERVAL (15 * 7) DAY)))))
GROUP BY
    1,
    2)

                select distinct order_items_created_week,
                order_items_created_hour_of_day,
                AVG(order_items_total_sale_price) OVER (PARTITION BY order_items_created_hour_of_day) AS mean,
                STDDEV(order_items_total_sale_price) OVER (PARTITION BY order_items_created_hour_of_day) AS std,
                SUM(order_items_total_sale_price) OVER (PARTITION BY order_items_created_hour_of_day, order_items_created_week) as sales
                FROM per_hour_per_week_sales  ;;
  }



  parameter: num_of_std_dev {
    type: number
  }

  dimension: high {
    type: number
    sql: ${mean} + ${std} * {% parameter num_of_std_dev %} ;;
  }

  dimension: low {
    type: number
    sql: ${mean} - ${std} * {% parameter num_of_std_dev %} ;;
  }



  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_created_week {
    type: string
    sql: ${TABLE}.order_items_created_week ;;
  }

  dimension: order_items_created_hour_of_day {
    type: number
    sql: ${TABLE}.order_items_created_hour_of_day ;;
  }

  dimension: mean {
    type: number
    sql: ${TABLE}.mean ;;
  }

  dimension: std {
    type: number
    sql: ${TABLE}.std ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  measure: total_high {
    type: sum
    sql: ${high} ;;
  }

  measure: total_low {
    type: sum
    sql: ${low} ;;
  }

  measure: total_sales {
    type: sum
    sql: ${sales} ;;
    value_format_name: usd_0
    html:

    {% if value <= total_low._value %}
    <b><p style="color: white; background-color: green">{{rendered_value}}</p></b>
    {% elsif value >= total_high._value %}
    <b><p style="color: white; background-color: red">{{rendered_value}}</p></b>
    {% else %}
   {{rendered_value}}
    {% endif %};;
  }

  set: detail {
    fields: [
      order_items_created_week,
      order_items_created_hour_of_day,
      mean,
      std,
      sales
    ]
  }
}
