-- Load only the ad_data1 and ad_data2 directories
data = LOAD '/dualcore/ad_data[12]' AS (campaign_id:chararray,
             date:chararray, time:chararray,
             keyword:chararray, display_site:chararray,
             placement:chararray, was_clicked:int, cpc:int);
-- A: Group everything so we can call the aggregate function
grouped = GROUP data ALL;
-- B: Find the highest cost of the next campaign
highest_cost = FOREACH grouped GENERATE MAX(data.cpc)*50000;
-- C: Display the result to the screen
DUMP highest_cost;

