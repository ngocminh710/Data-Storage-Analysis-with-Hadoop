--Lab: Gaining Insight with Sentiment Analysis
--Step 1:
--3
SELECT prod_id, FORMAT_NUMBER(avg_rating, 2) AS avg_rating
    FROM (SELECT prod_id, AVG(rating) AS avg_rating,
            COUNT(*) AS num
            FROM ratings
            GROUP BY prod_id) rated
    WHERE num >= 50
    ORDER BY avg_rating DESC
    LIMIT 1;
--4
SELECT prod_id, FORMAT_NUMBER(avg_rating, 2) AS avg_rating
    FROM (SELECT prod_id, AVG(rating) AS avg_rating,
            COUNT(*) AS num
            FROM ratings
            GROUP BY prod_id) rated
    WHERE num >= 50
    ORDER BY avg_rating ASC
    LIMIT 1;

--Step 2:
--1
SELECT EXPLODE(NGRAMS(SENTENCES(LOWER(message)),2,5)) 
    AS bigrams 
    FROM ratings 
    WHERE prod_id = 1274673;
--2
SELECT EXPLODE(NGRAMS(SENTENCES(LOWER(message)),3,5)) 
    AS trigrams 
    FROM ratings 
    WHERE prod_id = 1274673;
--3
SELECT message 
    FROM ratings 
    WHERE prod_id = 1274673 
      AND message LIKE '%ten times more%'
    LIMIT 3;
--4
SELECT message 
    FROM ratings 
    WHERE prod_id = 1274673 
      AND message LIKE '%red%'
    LIMIT 2;
--5
SELECT *
    FROM products
    WHERE prod_id = 1274673;
--6
SELECT * 
    FROM products 
    WHERE name LIKE '%16 GB USB Flash Drive%' 
      AND brand='Orion';
                                                                


