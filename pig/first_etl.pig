data = LOAD '/dualcore/ad_data1.txt';-- TODO finish the LOAD statement
data1 = LOAD '/dualcore/ad_data1.txt' AS (keyword:chararray, campaign_id:chararray, date:chararray, time:chararray, display_site:chararray, was_clicked:int, cpc:int, country:chararray, placement:chararray);
data2 = FILTER data1 BY NOT (country != 'USA');
data3 = FOREACH data2 GENERATE campaign_id, date, time, TRIM(UPPER(keyword)), display_site, placement, was_clicked, cpc;
STORE data3 into '/dualcore/ad_data1';
