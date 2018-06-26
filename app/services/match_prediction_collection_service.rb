class MatchPredictionCollectionService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def matches_with_predictions
    @mapped_rows ||= map_rows
  end

  private

  def map_rows
    query_result.map do |row|
      ::MatchPrediction.new(row)
    end
  end

  def query_result
    @result ||= ActiveRecord::Base.connection.execute(bookies_for_user_sql)
  end

  def bookies_for_user_sql
    <<-EOF
            SELECT m.id                               AS match_id
                 , lt.id                              AS left_team_id
                 , lt.fifa_country_code               AS left_team_fifa_country_code
                 , lt.name                            AS left_team_name
                 , rt.id                              AS right_team_id
                 , rt.fifa_country_code               AS right_team_fifa_country_code
                 , rt.name                            AS right_team_name
                 , m.phase                            AS match_phase
                 , m.left_team_score                  AS match_left_team_score
                 , m.right_team_score                 AS match_right_team_score
                 , m.kickoff_at                       AS match_kickoff_at
                 , m.created_at                       AS match_created_at
                 , m.updated_at                       AS match_updated_at
                 , p.id                               AS prediction_id
                 , p.left_team_score                  AS prediction_left_team_score
                 , p.right_team_score                 AS prediction_right_team_score
                 , p.points_left_team_score           AS prediction_points_left_team_score
                 , p.points_right_team_score          AS prediction_points_right_team_score
                 , p.points_overall_outcome           AS prediction_points_overall_outcome
                 , p.points_goal_difference           AS prediction_points_goal_difference
                 , p.points_total                     AS prediction_points_total
                 , p.created_at                       AS prediction_created_at
                 , p.updated_at                       AS prediction_updated_at
                 , v.name                             AS venue_name
                 , v.city                             AS venue_city
                 , v.what3words                       AS venue_what3words
                 , v.timezone                         AS venue_timezone
              FROM matches m
        INNER JOIN teams lt           ON lt.id      = m.left_team_id
        INNER JOIN teams rt           ON rt.id      = m.right_team_id
        INNER JOIN venues v           ON v.id       = m.venue_id
   LEFT OUTER JOIN predictions p      ON m.id       = p.match_id
                                     AND p.user_id  = #{user.id}
          ORDER BY m.kickoff_at
    EOF
  end
end
