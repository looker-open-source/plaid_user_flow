connection: "plaid-bigquery"

include: "*.view.lkml"                       # include all views in this project

explore: user_story_check {
  view_name: user_story_line
}

explore: user_story_summary {
  view_name: user_story_summary
}
