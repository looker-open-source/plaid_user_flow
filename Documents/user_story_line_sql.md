The following query is used to create the `user_story_line` table in KARTE Datahub that is the basis for the `user_story_line` view in this Looker Block.

```
{% set period_of_days = "60"%}
{%set  target_event = "_chat_open" %}
# edit target_event

with data as (
  SELECT user_id,session_id,sync_date,event_name
    ,if(event_name = "view"
      ,json_extract_scalar(values,"$.view.access.uri.url")
      ,"-") as url
    ,if(event_name = "message_open"
      ,json_extract_scalar(values,"$.message_open.message.campaign_id")
      ,if(event_name = "message_click"
        ,json_extract_scalar(values,"$.message_click.message.campaign_id")
      ,"-"
      )) as campaign_id
  FROM {{ karte_event("FORMAT_DATE('%Y%m%d', DATE_ADD(CURRENT_DATE, INTERVAL -" + period_of_days + " DAY))", "FORMAT_DATE('%Y%m%d', CURRENT_DATE)") }}
  where (
    event_name = "identify"
    or event_name = "view"
    or event_name = "message_open"
    or event_name = "message_click"
    or event_name = "{{target_event}}"
    )
  ),

target_event as (
  SELECT user_id,session_id,min(sync_date) as event_start
  FROM data
  where event_name = "{{target_event}}"
  group by user_id,session_id

  )


SELECT data.user_id,data.session_id,sync_date,event_name,url,campaign_id,event_start
  ,row_number() over(partition by data.session_id order by data.sync_date) as _no
from data
inner join target_event as t on data.user_id = t.user_id and data.session_id = t.session_id
where sync_date < event_start or (sync_date = event_start and event_name = "{{target_event}}")

order by user_id,sync_date
```
