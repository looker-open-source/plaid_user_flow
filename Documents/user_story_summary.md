The following query is used to create the `user_story_summary` table in KARTE Datahub that is the basis for the `user_story_summary` view in this Looker Block. Please insert your dataset name in `[your_dataset_name]` under the temporary table FROM clause.

```
with data as (
  SELECT user_id,session_id,sync_date,event_name
    ,concat(if(split(url,"/")[safe_offset(2)]is null,"",concat(split(url,"/")[safe_offset(2)]))
      ,if(split(url,"/")[safe_offset(3)]is null,"",concat("/",split(url,"/")[safe_offset(3)]))
      ,if(split(url,"/")[safe_offset(4)]is null,"",concat("/",split(url,"/")[safe_offset(4)]))
      ,if(split(url,"/")[safe_offset(5)]is null,"",concat("/",split(url,"/")[safe_offset(5)]))) as url_group
      # adjust the length of url_group
  FROM `prd-karte-per-client.[your_dataset_name].user_story_line`

  ),
arranged as (
  select *
    ,row_number() over (partition by session_id order by sync_date) as order_asc
    ,row_number() over (partition by session_id order by sync_date desc)-1 as order_desc
  from (
    select user_id,session_id,min(sync_date) as sync_date
      ,event_name,url_group
      ,sum(if(event_name="view",1,0)) as pv
    from  data
    group by user_id,session_id,event_name,url_group
    )
  )

select user_id,session_id,min(sync_date) as session_start
  ,any_value(if(order_asc=1,if(event_name = "view",url_group,event_name),null)) as event_url_top_1
  ,any_value(if(order_asc=2,if(event_name = "view",url_group,event_name),null)) as event_url_top_2
  ,any_value(if(order_asc=3,if(event_name = "view",url_group,event_name),null)) as event_url_top_3
  ,any_value(if(order_asc=4,if(event_name = "view",url_group,event_name),null)) as event_url_top_4
  ,any_value(if(order_asc=5,if(event_name = "view",url_group,event_name),null)) as event_url_top_5
  ,any_value(if(order_desc=1,if(event_name = "view",url_group,event_name),null)) as event_url_last_1
  ,any_value(if(order_desc=2,if(event_name = "view",url_group,event_name),null)) as event_url_last_2
  ,any_value(if(order_desc=3,if(event_name = "view",url_group,event_name),null)) as event_url_last_3
  ,any_value(if(order_desc=4,if(event_name = "view",url_group,event_name),null)) as event_url_last_4
  ,any_value(if(order_desc=5,if(event_name = "view",url_group,event_name),null)) as event_url_last_5
  ,sum(pv) as pv
from arranged
group by user_id,session_id
```
