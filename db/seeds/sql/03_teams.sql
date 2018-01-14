INSERT INTO teams (
    group_id
  , fifa_country_code
  , name
  , group_order
)
SELECT groups.id                  AS group_id
     , teams.fifa_country_code    AS fifa_country_code
     , teams.name                 AS name
     , teams.group_order          AS group_order
  FROM (
          SELECT 'A' group_name, 'RUS' fifa_country_code, 'Russia'          AS name, 1 AS group_order
    UNION SELECT 'A' group_name, 'KSA' fifa_country_code, 'Saudi Arabia'    AS name, 2 AS group_order
    UNION SELECT 'A' group_name, 'EGY' fifa_country_code, 'Egypt'           AS name, 3 AS group_order
    UNION SELECT 'A' group_name, 'URU' fifa_country_code, 'Uruguay'         AS name, 4 AS group_order
    UNION SELECT 'B' group_name, 'POR' fifa_country_code, 'Portugal'        AS name, 1 AS group_order
    UNION SELECT 'B' group_name, 'ESP' fifa_country_code, 'Spain'           AS name, 2 AS group_order
    UNION SELECT 'B' group_name, 'MAR' fifa_country_code, 'Marocco'         AS name, 3 AS group_order
    UNION SELECT 'B' group_name, 'IRN' fifa_country_code, 'Iran'            AS name, 4 AS group_order
    UNION SELECT 'C' group_name, 'FRA' fifa_country_code, 'France'          AS name, 1 AS group_order
    UNION SELECT 'C' group_name, 'AUS' fifa_country_code, 'Australia'       AS name, 2 AS group_order
    UNION SELECT 'C' group_name, 'PER' fifa_country_code, 'Peru'            AS name, 3 AS group_order
    UNION SELECT 'C' group_name, 'DEN' fifa_country_code, 'Denmark'         AS name, 4 AS group_order
    UNION SELECT 'D' group_name, 'ARG' fifa_country_code, 'Argentina'       AS name, 1 AS group_order
    UNION SELECT 'D' group_name, 'ISL' fifa_country_code, 'Iceland'         AS name, 2 AS group_order
    UNION SELECT 'D' group_name, 'CRO' fifa_country_code, 'Croatia'         AS name, 3 AS group_order
    UNION SELECT 'D' group_name, 'NGA' fifa_country_code, 'Nigeria'         AS name, 4 AS group_order
    UNION SELECT 'E' group_name, 'BRA' fifa_country_code, 'Brazil'          AS name, 1 AS group_order
    UNION SELECT 'E' group_name, 'SUI' fifa_country_code, 'Switzerland'     AS name, 2 AS group_order
    UNION SELECT 'E' group_name, 'CRC' fifa_country_code, 'Costa Rica'      AS name, 3 AS group_order
    UNION SELECT 'E' group_name, 'SRB' fifa_country_code, 'Serbia'          AS name, 4 AS group_order
    UNION SELECT 'F' group_name, 'GER' fifa_country_code, 'Germany'         AS name, 1 AS group_order
    UNION SELECT 'F' group_name, 'MEX' fifa_country_code, 'Mexico'          AS name, 2 AS group_order
    UNION SELECT 'F' group_name, 'SWE' fifa_country_code, 'Sweden'          AS name, 3 AS group_order
    UNION SELECT 'F' group_name, 'KOR' fifa_country_code, 'Korea Republic'  AS name, 4 AS group_order
    UNION SELECT 'G' group_name, 'BEL' fifa_country_code, 'Belgium'         AS name, 1 AS group_order
    UNION SELECT 'G' group_name, 'PAN' fifa_country_code, 'Panama'          AS name, 2 AS group_order
    UNION SELECT 'G' group_name, 'TUN' fifa_country_code, 'Tunisia'         AS name, 3 AS group_order
    UNION SELECT 'G' group_name, 'ENG' fifa_country_code, 'England'         AS name, 4 AS group_order
    UNION SELECT 'H' group_name, 'POL' fifa_country_code, 'Poland'          AS name, 1 AS group_order
    UNION SELECT 'H' group_name, 'SEN' fifa_country_code, 'Senegal'         AS name, 2 AS group_order
    UNION SELECT 'H' group_name, 'COL' fifa_country_code, 'Colombia'        AS name, 3 AS group_order
    UNION SELECT 'H' group_name, 'JPN' fifa_country_code, 'Japan'           AS name, 4 AS group_order
) teams
INNER JOIN groups           ON groups.name = teams.group_name
ON CONFLICT (fifa_country_code) DO
UPDATE
   SET group_id       = EXCLUDED.group_id
     , name           = EXCLUDED.name
     , group_order    = EXCLUDED.group_order
;
