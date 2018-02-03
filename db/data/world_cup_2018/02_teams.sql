INSERT INTO teams (
    group_letter
  , fifa_country_code
  , name
  , group_order
)
SELECT teams.group_letter         AS group_letter
     , teams.fifa_country_code    AS fifa_country_code
     , teams.name                 AS name
     , teams.group_order          AS group_order
  FROM (
          SELECT 'A' group_letter, 'RUS' fifa_country_code, 'Russia'          AS name, 1 AS group_order
    UNION SELECT 'A' group_letter, 'KSA' fifa_country_code, 'Saudi Arabia'    AS name, 2 AS group_order
    UNION SELECT 'A' group_letter, 'EGY' fifa_country_code, 'Egypt'           AS name, 3 AS group_order
    UNION SELECT 'A' group_letter, 'URU' fifa_country_code, 'Uruguay'         AS name, 4 AS group_order
    UNION SELECT 'B' group_letter, 'POR' fifa_country_code, 'Portugal'        AS name, 1 AS group_order
    UNION SELECT 'B' group_letter, 'ESP' fifa_country_code, 'Spain'           AS name, 2 AS group_order
    UNION SELECT 'B' group_letter, 'MAR' fifa_country_code, 'Marocco'         AS name, 3 AS group_order
    UNION SELECT 'B' group_letter, 'IRN' fifa_country_code, 'Iran'            AS name, 4 AS group_order
    UNION SELECT 'C' group_letter, 'FRA' fifa_country_code, 'France'          AS name, 1 AS group_order
    UNION SELECT 'C' group_letter, 'AUS' fifa_country_code, 'Australia'       AS name, 2 AS group_order
    UNION SELECT 'C' group_letter, 'PER' fifa_country_code, 'Peru'            AS name, 3 AS group_order
    UNION SELECT 'C' group_letter, 'DEN' fifa_country_code, 'Denmark'         AS name, 4 AS group_order
    UNION SELECT 'D' group_letter, 'ARG' fifa_country_code, 'Argentina'       AS name, 1 AS group_order
    UNION SELECT 'D' group_letter, 'ISL' fifa_country_code, 'Iceland'         AS name, 2 AS group_order
    UNION SELECT 'D' group_letter, 'CRO' fifa_country_code, 'Croatia'         AS name, 3 AS group_order
    UNION SELECT 'D' group_letter, 'NGA' fifa_country_code, 'Nigeria'         AS name, 4 AS group_order
    UNION SELECT 'E' group_letter, 'BRA' fifa_country_code, 'Brazil'          AS name, 1 AS group_order
    UNION SELECT 'E' group_letter, 'SUI' fifa_country_code, 'Switzerland'     AS name, 2 AS group_order
    UNION SELECT 'E' group_letter, 'CRC' fifa_country_code, 'Costa Rica'      AS name, 3 AS group_order
    UNION SELECT 'E' group_letter, 'SRB' fifa_country_code, 'Serbia'          AS name, 4 AS group_order
    UNION SELECT 'F' group_letter, 'GER' fifa_country_code, 'Germany'         AS name, 1 AS group_order
    UNION SELECT 'F' group_letter, 'MEX' fifa_country_code, 'Mexico'          AS name, 2 AS group_order
    UNION SELECT 'F' group_letter, 'SWE' fifa_country_code, 'Sweden'          AS name, 3 AS group_order
    UNION SELECT 'F' group_letter, 'KOR' fifa_country_code, 'Korea Republic'  AS name, 4 AS group_order
    UNION SELECT 'G' group_letter, 'BEL' fifa_country_code, 'Belgium'         AS name, 1 AS group_order
    UNION SELECT 'G' group_letter, 'PAN' fifa_country_code, 'Panama'          AS name, 2 AS group_order
    UNION SELECT 'G' group_letter, 'TUN' fifa_country_code, 'Tunisia'         AS name, 3 AS group_order
    UNION SELECT 'G' group_letter, 'ENG' fifa_country_code, 'England'         AS name, 4 AS group_order
    UNION SELECT 'H' group_letter, 'POL' fifa_country_code, 'Poland'          AS name, 1 AS group_order
    UNION SELECT 'H' group_letter, 'SEN' fifa_country_code, 'Senegal'         AS name, 2 AS group_order
    UNION SELECT 'H' group_letter, 'COL' fifa_country_code, 'Colombia'        AS name, 3 AS group_order
    UNION SELECT 'H' group_letter, 'JPN' fifa_country_code, 'Japan'           AS name, 4 AS group_order
) teams
ON CONFLICT (fifa_country_code) DO
UPDATE
   SET group_letter   = EXCLUDED.group_letter
     , name           = EXCLUDED.name
     , group_order    = EXCLUDED.group_order
;
