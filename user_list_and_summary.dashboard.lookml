- dashboard: user_list_and_summary
  title: user_list_and_summary
  layout: newspaper
  elements:
  - title: user_list
    name: user_list
    model: user_story
    explore: user_story_check
    type: table
    fields: [user_story_line.user_id, user_story_line.session_id, user_story_line.session_start_date,
      user_story_line.pv]
    sorts: [user_story_line.pv desc]
    limit: 500
    query_timezone: UTC
    row: 5
    col: 0
    width: 24
    height: 8
  - title: distribution of PV
    name: distribution of PV
    model: user_story
    explore: user_story_summary
    type: looker_column
    fields: [user_story_summary.pv, user_story_summary.user_count]
    sorts: [user_story_summary.pv]
    limit: 500
    query_timezone: UTC
    series_types: {}
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 5
  - title: summary_first_5_event
    name: summary_first_5_event
    model: user_story
    explore: user_story_summary
    type: looker_grid
    fields: [user_story_summary.user_count, user_story_summary.event_url_top_1, user_story_summary.event_url_top_2,
      user_story_summary.event_url_top_3, user_story_summary.event_url_top_4, user_story_summary.event_url_top_5]
    sorts: [user_story_summary.user_count desc]
    limit: 500
    query_timezone: UTC
    series_types: {}
    series_column_widths:
      user_story_summary.event_url_last_5: 205
      user_story_summary.event_url_last_4: 282
    listen: {}
    row: 21
    col: 0
    width: 24
    height: 8
  - title: summary_last_5_event
    name: summary_last_5_event
    model: user_story
    explore: user_story_summary
    type: looker_grid
    fields: [user_story_summary.event_url_last_5, user_story_summary.event_url_last_4,
      user_story_summary.event_url_last_3, user_story_summary.event_url_last_2, user_story_summary.event_url_last_1,
      user_story_summary.user_count]
    sorts: [user_story_summary.user_count desc]
    limit: 500
    query_timezone: UTC
    series_types: {}
    series_column_widths:
      user_story_summary.event_url_last_5: 205
      user_story_summary.event_url_last_4: 282
    listen: {}
    row: 13
    col: 0
    width: 24
    height: 8
