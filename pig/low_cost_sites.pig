-- TODO (A): Replace 'FIXME' to load the test_ad_data.txt file.

data = LOAD '/dualcore/ad_data[12]' AS (campaign_id:chararray,
             date:chararray, time:chararray,
             keyword:chararray, display_site:chararray, 
             placement:chararray, was_clicked:int, cpc:int);


-- TODO (B): Include only records where was_clicked has a value of 1
clicked = FILTER data BY was_clicked == 1;

-- TODO (C): Group the data by the appropriate field
grouped = GROUP clicked BY display_site;

/* TODO (D): Create a new relation which includes only the 
 *           display site and the total cost of all clicks 
 *           on that site
 */
data1 = FOREACH grouped GENERATE group AS display_site, SUM(clicked.cpc) AS total_cost;


-- TODO (E): Sort that new relation by cost (ascending)
data1 = ORDER data1 BY total_cost ASC;

-- TODO (F): Display just the first three records to the screen
first_three = LIMIT data1 3;

DUMP first_three;
