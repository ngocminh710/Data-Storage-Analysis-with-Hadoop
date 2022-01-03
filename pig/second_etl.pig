data = LOAD '/dualcore/ad_data2.txt'; -- TODO finish the LOAD statement
data1 = LOAD '/dualcore/ad_data2.txt' USING PigStorage(',') AS (campaign_id:chararray, date:chararray, time:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int, keyword:chararray);
data2 = DISTINCT data1;
data3 = FOREACH data2 GENERATE campaign_id, REPLACE(date, '-', '/'), time, TRIM(UPPER(keyword)), display_site, placement, was_clicked, cpc;
STORE data3 into '/dualcore/ad_data2';
