class UpdatePredictionsPointsService
  attr_reader :match

  def initialize(match = nil)
    @match = match
  end

  def run!
    ActiveRecord::Base.connection.execute(update_predictions_points_sql)
  end

  private

  def update_predictions_points_sql
    <<-SQL
      WITH final_points AS (
        SELECT r.prediction_id                      AS prediction_id
             , r.points_left_team_score             AS points_left_team_score
             , r.points_right_team_score            AS points_right_team_score
             , r.points_overall_outcome             AS points_overall_outcome
             , r.points_goal_difference             AS points_goal_difference
             , (
                r.points_left_team_score +
                r.points_right_team_score +
                r.points_overall_outcome +
                r.points_goal_difference
              )                                     AS points_total
          FROM (
          SELECT mpe.match_id                         AS match_id
               , mpe.match_left_team_score            AS match_left_team_score
               , mpe.match_right_team_score           AS match_right_team_score
               , mpe.match_goal_difference            AS match_goal_difference
               , mpe.match_overall_outcome            AS match_overall_outcome
               , '--- Prediction --->'                AS spacer_1
               , mpe.prediction_id                    AS prediction_id
               , mpe.prediction_left_team_score       AS prediction_left_team_score
               , mpe.prediction_right_team_score      AS prediction_right_team_score
               , mpe.prediction_goal_difference       AS prediction_goal_difference
               , mpe.prediction_overall_outcome       AS prediction_overall_outcome
               , '--- Points --->'                    AS spacer_2
               , CASE
                   WHEN match_left_team_score = prediction_left_team_score THEN 2
                   ELSE 0
                 END                                  AS points_left_team_score
               , CASE
                   WHEN match_right_team_score = prediction_right_team_score THEN 2
                   ELSE 0
                 END                                  AS points_right_team_score
               , CASE
                   WHEN match_overall_outcome = prediction_overall_outcome THEN 5
                   ELSE 0
                 END                                  AS points_overall_outcome
               , CASE
                   WHEN match_goal_difference = prediction_goal_difference THEN 1
                   ELSE 0
                 END                                  AS points_goal_difference
            FROM (
            SELECT me.match_id                        AS match_id
                 , me.match_left_team_score           AS match_left_team_score
                 , me.match_right_team_score          AS match_right_team_score
                 , me.match_goal_difference           AS match_goal_difference
                 , me.match_overall_outcome           AS match_overall_outcome
                 , pe.prediction_id                   AS prediction_id
                 , pe.prediction_left_team_score      AS prediction_left_team_score
                 , pe.prediction_right_team_score     AS prediction_right_team_score
                 , pe.prediction_goal_difference      AS prediction_goal_difference
                 , pe.prediction_overall_outcome      AS prediction_overall_outcome
              FROM (
                SELECT m.id                                     AS match_id
                     , m.left_team_score                        AS match_left_team_score
                     , m.right_team_score                       AS match_right_team_score
                     , (m.left_team_score - m.right_team_score) AS match_goal_difference
                     , CASE
                         WHEN (m.left_team_score > m.right_team_score) THEN 'LEFT'
                         WHEN (m.right_team_score > m.left_team_score) THEN 'RIGHT'
                         ELSE 'TIE'
                       END                                      AS match_overall_outcome
                  FROM matches m
                 WHERE 0 = 0
                   AND m.left_team_score  IS NOT NULL
                   AND m.right_team_score IS NOT NULL
                   AND #{match_filter_sql}
            ) me /* matches enriched */
            INNER JOIN (
                SELECT p.id                                     AS prediction_id
                     , p.match_id                               AS prediction_match_id
                     , p.left_team_score                        AS prediction_left_team_score
                     , p.right_team_score                       AS prediction_right_team_score
                     , (p.left_team_score - p.right_team_score) AS prediction_goal_difference
                     , CASE
                         WHEN (p.left_team_score > p.right_team_score) THEN 'LEFT'
                         WHEN (p.right_team_score > p.left_team_score) THEN 'RIGHT'
                         ELSE 'TIE'
                       END                                      AS prediction_overall_outcome
                  FROM predictions p
                 WHERE 0 = 0
                   AND p.left_team_score  IS NOT NULL
                   AND p.right_team_score IS NOT NULL
            ) pe /* predictions enriched */ ON pe.prediction_match_id = me.match_id
          ) mpe /* matches and predictions enriched */
        ) r /* results */
      )
      UPDATE predictions
         SET points_left_team_score  = final_points.points_left_team_score
           , points_right_team_score = final_points.points_right_team_score
           , points_overall_outcome  = final_points.points_overall_outcome
           , points_goal_difference  = final_points.points_goal_difference
           , points_total            = final_points.points_total
        FROM final_points
       WHERE predictions.id = final_points.prediction_id
    SQL
  end

  def match_filter_sql
    return '0 = 0' unless match.present?

    "m.id = #{match.id}"
  end
end
