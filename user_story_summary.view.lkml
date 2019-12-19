view: user_story_summary {
  sql_table_name: `prd-karte-per-client.@{DATASET_NAME}.user_story_summary` ;;


  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(cast(${TABLE}.order_asc, as string),${TABLE}.session_id) ;;
  }

  dimension: date {
    type: date_time
    group_label: "Time"
    sql: ${TABLE}.session_start ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    link: {
      label: "KARTE User Story"
      icon_url: "https://admin.karte.io/images/baisu/logo_mark.svg"
      url: "https://admin.karte.io/p/@{ORGANIZATION_ID}/user/{{value}}"
    }
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    link: {
      label: "story line detail"
      url:"/looks/XX?&f[user_story_line.session_id]={{ value }}"
      # put the look NO you registerd in XXX, please check the readme file
    }
  }
  dimension: pv {
    type: number
    sql: ${TABLE}.pv ;;
  }

  dimension: event_url_top_1 {
    type: string
    sql: ${TABLE}.event_url_top_1 ;;
  }
  dimension: event_url_top_2 {
    type: string
    sql: ${TABLE}.event_url_top_2 ;;
  }
  dimension: event_url_top_3 {
    type: string
    sql: ${TABLE}.event_url_top_3 ;;
  }
  dimension: event_url_top_4 {
    type: string
    sql: ${TABLE}.event_url_top_4 ;;
  }
  dimension: event_url_top_5 {
    type: string
    sql: ${TABLE}.event_url_top_5 ;;
  }
  dimension: event_url_last_1 {
    type: string
    sql: ${TABLE}.event_url_last_1 ;;
  }
  dimension: event_url_last_2 {
    type: string
    sql: ${TABLE}.event_url_last_2 ;;
  }
  dimension: event_url_last_3 {
    type: string
    sql: ${TABLE}.event_url_last_3 ;;
  }
  dimension: event_url_last_4 {
    type: string
    sql: ${TABLE}.event_url_last_4 ;;
  }
  dimension: event_url_last_5 {
    type: string
    sql: ${TABLE}.event_url_last_5 ;;
  }
  measure: user_count {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
    drill_fields: [detail*]
  }

  set: detail{
    fields: [user_id,session_id,date]
  }

}
