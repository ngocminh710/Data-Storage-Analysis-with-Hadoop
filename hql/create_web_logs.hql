-- The following is an example of what a line from a Web server log file looks like
-- 
-- 10.21.147.9 - - [31/May/2013:00:00:04 -0800] "GET /tablet.html HTTP/1.1" 200 9652 "http://www.google.com/search?q=tablet" "ACME Browser 1.0" "SESSIONID=280493516274"


CREATE EXTERNAL TABLE web_logs (
  ip_address STRING,
  date_string STRING,
  request STRING,
  status STRING,
  bytes STRING,
  referer STRING,
  user_agent STRING,
  cookie STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
   "input.regex" = "^([\\d.]+) \\S+ \\S+ \\[(.+?)\\] \\\"(.+?)\\\" (\\d{3}) (\\d+) \\\"(.+?)\\\" \\\"(.+?)\\\" \\\"SESSIONID=(\\d+)\\\"\\s*"
)
LOCATION '/dualcore/web_logs';
