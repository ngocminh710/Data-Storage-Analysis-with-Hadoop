ADD FILE ipgeolocator.py;

CREATE TABLE cart_zipcodes AS
    SELECT TRANSFORM(cookie, ip_address, steps_completed)
        USING 'ipgeolocator.py' AS (cookie STRING, zipcode STRING, steps_completed INT)
        FROM checkout_sessions;
