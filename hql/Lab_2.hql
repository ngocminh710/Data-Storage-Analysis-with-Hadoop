--Lab: Data Transformation with Hive
--Step 1:
--5
SELECT term, COUNT(term) AS num FROM (SELECT LOWER(REGEXP_EXTRACT(request,'/search\\?phrase=(\\S+)',1)) AS term FROM web_logs WHERE request REGEXP '/search\\?phrase=') terms GROUP BY term ORDER BY num DESC LIMIT 3; 
                                                             
--Step 2:
--1
SELECT COUNT(*),request 
   FROM web_logs 
   WHERE request REGEXP '/cart/checkout/step\\d.+'
   GROUP BY request;
--2
CREATE TABLE checkout_sessions AS 
  SELECT cookie, ip_address, COUNT(request) AS steps_completed 
     FROM web_logs 
     WHERE request REGEXP '/cart/checkout/step\\d.+' 
     GROUP BY cookie, ip_address;
--3
SELECT steps_completed, COUNT(cookie) AS num 
    FROM checkout_sessions 
    GROUP BY steps_completed;

--Step 3
--Step 4
--1
CREATE TABLE cart_items AS 
  SELECT cookie, REGEXP_EXTRACT(request, '/cart/additem\\?productid=(\\d+)',1) AS prod_id 
  FROM web_logs 
  WHERE request REGEXP '/cart/additem\\?productid=(\\d+)';
--3
SELECT COUNT(DISTINCT cookie) FROM cart_items WHERE prod_id=1273905;

--Step 5
CREATE TABLE cart_orders AS 
  SELECT z.cookie, steps_completed, zipcode, 
      SUM(shipping_wt) as total_weight, 
      SUM(price) AS total_price, 
      SUM(cost) AS total_cost 
  FROM cart_zipcodes z 
  JOIN cart_items i 
    ON (z.cookie = i.cookie) 
  JOIN products p 
    ON (i.prod_id = p.prod_id)
  GROUP BY z.cookie, zipcode, steps_completed;
 
--Step 6
--1
Add JAR /home/training/training_materials/analyst/exercises/transform/geolocation_udf.jar;
--2
CREATE TEMPORARY FUNCTION CALC_SHIPPING_COST AS 'com.cloudera.hive.udf.UDFCalcShippingCost';
--3
CREATE TABLE cart_shipping AS 
   SELECT cookie, steps_completed, total_price, total_cost,  CALC_SHIPPING_COST(zipcode, total_weight) AS shipping_cost 
   FROM cart_orders;
--4
SELECT * FROM cart_shipping WHERE cookie='100002920697';


                                                                             

