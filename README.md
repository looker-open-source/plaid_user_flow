## Block OVerview
- The User Flow Block by KARTE enables users to take action to promote or discourage specific user event flows by analyzing how customers navigate your websites.

## Analyses
- This block uses both individual user behavior and aggregate trends to produce qualitative insights.
  - Here's an example walk-through of how to the block might be used:
    1. Understand when target user events are triggered the most from event distribution analysis (Distribution PV).
    2. Select a few users based on their pageview count (user_list).
    3. Drill into each session ID to observe event flows by user.
    4. Develop hypotheses as to user behavior before target events.
    5. Test hypotheses by referencing other users who have gone through the same steps (user_story_summary).

## How to Implement the Block

### In Looker
- Turn On Project Import: In order to use the project manifest file for dataset name declaration, project import needs to be turned on under the Admin > Labs section.
- Set Project Name to Your Service Account Project: While the dataset will show up in KARTE as a part of the prd-karte-per-client project, you will be accessing it through your service account project (most likely prd-karte-service-account-2). Otherwise, you will get a BigQuery permission error.
- Declare Dataset Name and Organization ID: You need to declare your dataset name in the dataset_name and organization_id constants in the project manifest file.
- Save a new Look using the following link:
    - user story line :  https://XXX.looker.com/explore/XXX/user_story_check?fields=user_story_line.user_id,user_story_line.session_id,user_story_line.date,user_story_line.event_name,user_story_line.url,user_story_line.campaign_id&sorts=user_story_line.date+desc&limit=500&query_timezone=UTC&vis=%7B%22type%22%3A%22table%22%7D&filter_config=%7B%7D&dynamic_fields=%5B%5D&origin=share-expanded
- Define the following two constants in the manifest file:
  - dataset_name: THe dataset name where your tables are created.
  - organization_id: Your KARTE organization ID found in the KARTE admin link (XXX in "https://admin.karte.io/p/XXX/user/").

### In KARTE
- Create Job Flows: There needs to be a set of job flows (i.e. automatically triggered queries) in KARTE DataHub to create and refresh tables Looker will use for queries.
- Create A Service Account: You'll need to create a new GCP service account in KARTE DataHub in order for Looker to query your KARTE data.
- Share the Newly Created Dataset: Click on the ellipses next to the project name, and share the dataset with the service account.
