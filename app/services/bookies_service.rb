class BookiesService
  attr_reader :user

  Row         = Struct.new(:match, :left_team, :right_team, :prediction)
  Match       = Struct.new(:id, :phase, :left_team_score, :right_team_score, :kickoff_at, :created_at, :updated_at)
  LeftTeam    = Struct.new(:id, :fifa_country_code, :name)
  RightTeam   = Struct.new(:id, :fifa_country_code, :name)
  Prediction  = Struct.new(:id, :left_team_score, :right_team_score, :points_left_team_score, :points_right_team_score, :points_overall_outcome, :points_goal_difference, :created_at, :updated_at)


  def initialize(user)
    @user = user
  end

  def rows
    @mapped_rows ||= map_rows
  end

  private

  def map_rows
    query_result.map do |row|
      row_data = Row.new(Match.new, LeftTeam.new, RightTeam.new, Prediction.new)

      row_data.members.each do |table_name|
        row_data[table_name].members.each do |column_name|
          selector_name = "#{table_name}_#{column_name}"
          row_data[table_name][column_name] = row.fetch(selector_name)
        end
      end
      row_data
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
                 , p.created_at                       AS prediction_created_at
                 , p.updated_at                       AS prediction_updated_at
              FROM matches m
        INNER JOIN teams lt           ON lt.id      = m.left_team_id
        INNER JOIN teams rt           ON rt.id      = m.right_team_id
   LEFT OUTER JOIN predictions p      ON m.id       = p.match_id
                                     AND p.user_id  = #{user.id}
          ORDER BY m.kickoff_at
    EOF
  end
end
