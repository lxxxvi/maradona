INSERT INTO matches (
    venue_id
  , phase
  , left_team_id
  , right_team_id
  , kickoff_at
  , created_at
  , updated_at
)
SELECT venue.id                   AS venue_id
     , 'Group stage'::text        AS phase
     , left_team.id               AS left_team_id
     , right_team.id              AS right_team_id
     , match.kickoff_at           AS kickoff_at
     , now()                      AS created_at
     , now()                      AS updated_at
  FROM (
        SELECT 'sweetly.detained.venues'::text                      AS venue
             , 'RUS'::text                                          AS left_team_code
             , 'KSA'::text                                          AS right_team_code
             , TIMESTAMP WITH TIME ZONE '2018-06-14 15:00:00+00'    AS kickoff_at

  UNION SELECT 'binders.earl.area'::text                            AS venue
             , 'EGY'::text                                          AS left_team_code
             , 'URU'::text                                          AS right_team_code
             , TIMESTAMP WITH TIME ZONE '2018-06-15 12:00:00+00'    AS kickoff_at

  UNION SELECT 'caravan.revives.jigging'::text                      AS venue
             , 'MAR'::text                                          AS left_team_code
             , 'IRN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-15 15:00:00+00'   AS kickoff_at

  UNION SELECT 'bandaging.flustered.minutiae'::text                 AS venue
             , 'POR'::text                                          AS left_team_code
             , 'ESP'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-15 18:00:00+00'   AS kickoff_at

  UNION SELECT 'recover.news.deeply'::text                          AS venue
             , 'FRA'::text                                          AS left_team_code
             , 'AUS'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-16 10:00:00+00'   AS kickoff_at

  UNION SELECT 'slap.flicks.late'::text                             AS venue
             , 'ARG'::text                                          AS left_team_code
             , 'ISL'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-16 13:00:00+00'   AS kickoff_at

  UNION SELECT 'blinks.corn.commands'::text                         AS venue
             , 'PER'::text                                          AS left_team_code
             , 'DEN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-16 16:00:00+00'   AS kickoff_at

  UNION SELECT 'slick.texted.star'::text                            AS venue
             , 'CRO'::text                                          AS left_team_code
             , 'NGA'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-16 19:00:00+00'   AS kickoff_at

  UNION SELECT 'cats.sweeper.struck'::text                          AS venue
             , 'CRC'::text                                          AS left_team_code
             , 'SRB'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-17 12:00:00+00'   AS kickoff_at

  UNION SELECT 'sweetly.detained.venues'::text                      AS venue
             , 'GER'::text                                          AS left_team_code
             , 'MEX'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-17 15:00:00+00'   AS kickoff_at

  UNION SELECT 'tempting.prude.natively'::text                      AS venue
             , 'BRA'::text                                          AS left_team_code
             , 'SUI'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-17 18:00:00+00'   AS kickoff_at

  UNION SELECT 'years.burying.fewest'::text                         AS venue
             , 'SWE'::text                                          AS left_team_code
             , 'KOR'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-18 12:00:00+00'   AS kickoff_at

  UNION SELECT 'bandaging.flustered.minutiae'::text                 AS venue
             , 'BEL'::text                                          AS left_team_code
             , 'PAN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-18 15:00:00+00'   AS kickoff_at

  UNION SELECT 'humidity.recoup.cookery'::text                      AS venue
             , 'TUN'::text                                          AS left_team_code
             , 'ENG'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-18 18:00:00+00'   AS kickoff_at

  UNION SELECT 'blinks.corn.commands'::text                         AS venue
             , 'COL'::text                                          AS left_team_code
             , 'JPN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-19 12:00:00+00'   AS kickoff_at

  UNION SELECT 'slap.flicks.late'::text                             AS venue
             , 'POL'::text                                          AS left_team_code
             , 'SEN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-19 15:00:00+00'   AS kickoff_at

  UNION SELECT 'caravan.revives.jigging'::text                      AS venue
             , 'RUS'::text                                          AS left_team_code
             , 'EGY'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-19 18:00:00+00'   AS kickoff_at

  UNION SELECT 'sweetly.detained.venues'::text                      AS venue
             , 'POR'::text                                          AS left_team_code
             , 'MAR'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-20 12:00:00+00'   AS kickoff_at

  UNION SELECT 'tempting.prude.natively'::text                      AS venue
             , 'URU'::text                                          AS left_team_code
             , 'KSA'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-20 15:00:00+00'   AS kickoff_at

  UNION SELECT 'recover.news.deeply'::text                          AS venue
             , 'IRN'::text                                          AS left_team_code
             , 'ESP'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-20 18:00:00+00'   AS kickoff_at

  UNION SELECT 'cats.sweeper.struck'::text                          AS venue
             , 'DEN'::text                                          AS left_team_code
             , 'AUS'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-21 12:00:00+00'   AS kickoff_at

  UNION SELECT 'binders.earl.area'::text                            AS venue
             , 'FRA'::text                                          AS left_team_code
             , 'PER'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-21 15:00:00+00'   AS kickoff_at

  UNION SELECT 'years.burying.fewest'::text                         AS venue
             , 'ARG'::text                                          AS left_team_code
             , 'CRO'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-21 18:00:00+00'   AS kickoff_at

  UNION SELECT 'caravan.revives.jigging'::text                      AS venue
             , 'BRA'::text                                          AS left_team_code
             , 'CRC'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-22 12:00:00+00'   AS kickoff_at

  UNION SELECT 'humidity.recoup.cookery'::text                      AS venue
             , 'NGA'::text                                          AS left_team_code
             , 'ISL'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-22 15:00:00+00'   AS kickoff_at

  UNION SELECT 'slick.texted.star'::text                            AS venue
             , 'SRB'::text                                          AS left_team_code
             , 'SUI'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-22 18:00:00+00'   AS kickoff_at

  UNION SELECT 'slap.flicks.late'::text                             AS venue
             , 'BEL'::text                                          AS left_team_code
             , 'TUN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-23 12:00:00+00'   AS kickoff_at

  UNION SELECT 'tempting.prude.natively'::text                      AS venue
             , 'KOR'::text                                          AS left_team_code
             , 'MEX'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-23 15:00:00+00'   AS kickoff_at

  UNION SELECT 'bandaging.flustered.minutiae'::text                 AS venue
             , 'GER'::text                                          AS left_team_code
             , 'SWE'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-23 18:00:00+00'   AS kickoff_at

  UNION SELECT 'years.burying.fewest'::text                         AS venue
             , 'ENG'::text                                          AS left_team_code
             , 'PAN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-24 12:00:00+00'   AS kickoff_at

  UNION SELECT 'binders.earl.area'::text                            AS venue
             , 'JPN'::text                                          AS left_team_code
             , 'SEN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-24 15:00:00+00'   AS kickoff_at

  UNION SELECT 'recover.news.deeply'::text                          AS venue
             , 'POL'::text                                          AS left_team_code
             , 'COL'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-24 18:00:00+00'   AS kickoff_at

  UNION SELECT 'cats.sweeper.struck'::text                          AS venue
             , 'URU'::text                                          AS left_team_code
             , 'RUS'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-25 14:00:00+00'   AS kickoff_at

  UNION SELECT 'humidity.recoup.cookery'::text                      AS venue
             , 'KSA'::text                                          AS left_team_code
             , 'EGY'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-25 14:00:00+00'   AS kickoff_at

  UNION SELECT 'blinks.corn.commands'::text                         AS venue
             , 'IRN'::text                                          AS left_team_code
             , 'POR'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-25 18:00:00+00'   AS kickoff_at

  UNION SELECT 'slick.texted.star'::text                            AS venue
             , 'ESP'::text                                          AS left_team_code
             , 'MAR'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-25 18:00:00+00'   AS kickoff_at

  UNION SELECT 'sweetly.detained.venues'::text                      AS venue
             , 'DEN'::text                                          AS left_team_code
             , 'FRA'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-26 14:00:00+00'   AS kickoff_at

  UNION SELECT 'bandaging.flustered.minutiae'::text                 AS venue
             , 'AUS'::text                                          AS left_team_code
             , 'PER'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-26 14:00:00+00'   AS kickoff_at

  UNION SELECT 'caravan.revives.jigging'::text                      AS venue
             , 'NGA'::text                                          AS left_team_code
             , 'ARG'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-26 18:00:00+00'   AS kickoff_at

  UNION SELECT 'tempting.prude.natively'::text                      AS venue
             , 'ISL'::text                                          AS left_team_code
             , 'CRO'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-26 18:00:00+00'   AS kickoff_at

  UNION SELECT 'binders.earl.area'::text                            AS venue
             , 'MEX'::text                                          AS left_team_code
             , 'SWE'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-27 14:00:00+00'   AS kickoff_at

  UNION SELECT 'recover.news.deeply'::text                          AS venue
             , 'KOR'::text                                          AS left_team_code
             , 'GER'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-27 14:00:00+00'   AS kickoff_at

  UNION SELECT 'slap.flicks.late'::text                             AS venue
             , 'SRB'::text                                          AS left_team_code
             , 'BRA'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-27 18:00:00+00'   AS kickoff_at

  UNION SELECT 'years.burying.fewest'::text                         AS venue
             , 'SUI'::text                                          AS left_team_code
             , 'CRC'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-27 18:00:00+00'   AS kickoff_at

  UNION SELECT 'humidity.recoup.cookery'::text                      AS venue
             , 'JPN'::text                                          AS left_team_code
             , 'POL'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-28 14:00:00+00'   AS kickoff_at

  UNION SELECT 'cats.sweeper.struck'::text                          AS venue
             , 'SEN'::text                                          AS left_team_code
             , 'COL'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-28 14:00:00+00'   AS kickoff_at

  UNION SELECT 'blinks.corn.commands'::text                         AS venue
             , 'PAN'::text                                          AS left_team_code
             , 'TUN'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-28 18:00:00+00'   AS kickoff_at

  UNION SELECT 'slick.texted.star'::text                            AS venue
             , 'ENG'::text                                          AS left_team_code
             , 'BEL'::text                                          AS right_team_code
             ,  TIMESTAMP WITH TIME ZONE '2018-06-28 18:00:00+00'   AS kickoff_at
) match
INNER JOIN venues      venue     ON venue.what3words              = match.venue
INNER JOIN teams   left_team     ON left_team.fifa_country_code   = match.left_team_code
INNER JOIN teams   right_team    ON right_team.fifa_country_code  = match.right_team_code
ON CONFLICT (phase, left_team_id, right_team_id) DO
 UPDATE
    SET venue_id       = EXCLUDED.venue_id
      , kickoff_at     = EXCLUDED.kickoff_at
      , updated_at     = EXCLUDED.updated_at
;
