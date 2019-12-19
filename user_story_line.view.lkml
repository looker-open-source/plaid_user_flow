view: user_story_line {
  sql_table_name: `prd-karte-per-client.@{DATASET_NAME}.user_story_line` ;;


  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(cast(${TABLE}._no, as string),${TABLE}.session_id) ;;
  }

  dimension: date {
    type: date_time
    group_label: "Time"
    sql: ${TABLE}.sync_date ;;
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
      url:"/looks/@{SAVED_LOOK_NUMBER}?&f[user_story_line.session_id]={{ value }}"
      # For this to correctly work, plesae insert the Look ID you registerd
      # as the value of SAVED_LOOK_NUMBER in the manifest file.
    }
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  measure: session_start_date {
    type: date_time
    sql: min(${TABLE}.sync_date) ;;
  }
  measure: pv {
    type: sum
    sql: if(${TABLE}.event_name="view",1,0) ;;
  }

}
