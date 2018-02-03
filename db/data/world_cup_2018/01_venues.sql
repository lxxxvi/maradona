INSERT INTO venues (
    what3words
  , name
  , city
  , timezone
)
SELECT venue.what3words
     , venue.name
     , venue.city
     , venue.timezone
  FROM (
        SELECT 'Luzhniki Stadium'        AS name , 'Moscow'           AS city , '+0300' AS timezone , 'sweetly.detained.venues'       AS what3words
  UNION SELECT 'Otkrytiye Arena'         AS name , 'Moscow'           AS city , '+0300' AS timezone , 'slap.flicks.late'              AS what3words
  UNION SELECT 'Krestovsky Stadium'      AS name , 'Saint Petersburg' AS city , '+0300' AS timezone , 'caravan.revives.jigging'       AS what3words
  UNION SELECT 'Kaliningrad Stadium'     AS name , 'Kaliningrad'      AS city , '+0200' AS timezone , 'slick.texted.star'             AS what3words
  UNION SELECT 'Kazan Arena'             AS name , 'Kazan'            AS city , '+0300' AS timezone , 'recover.news.deeply'           AS what3words
  UNION SELECT 'Nizhny Novgorod Stadium' AS name , 'Nizhny Novgorod'  AS city , '+0300' AS timezone , 'years.burying.fewest'          AS what3words
  UNION SELECT 'Cosmos Arena'            AS name , 'Samara'           AS city , '+0400' AS timezone , 'cats.sweeper.struck'           AS what3words
  UNION SELECT 'Volgograd Arena'         AS name , 'Volgograd'        AS city , '+0300' AS timezone , 'humidity.recoup.cookery'       AS what3words
  UNION SELECT 'Mordovia Arena'          AS name , 'Saransk'          AS city , '+0300' AS timezone , 'blinks.corn.commands'          AS what3words
  UNION SELECT 'Rostov Arena'            AS name , 'Rostov on Don'    AS city , '+0300' AS timezone , 'tempting.prude.natively'       AS what3words
  UNION SELECT 'Fisht Olympic Stadium'   AS name , 'Sochi'            AS city , '+0300' AS timezone , 'bandaging.flustered.minutiae'  AS what3words
  UNION SELECT 'Central Stadium'         AS name , 'Yekaterinburg'    AS city , '+0500' AS timezone , 'binders.earl.area'             AS what3words
) venue
ON CONFLICT (what3words) DO
UPDATE
   SET name       = EXCLUDED.name
     , city       = EXCLUDED.city
     , timezone   = EXCLUDED.timezone
;
