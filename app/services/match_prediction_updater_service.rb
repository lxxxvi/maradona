class MatchPredictionUpdaterService
  attr_reader :prediction

  def initialize(match, user)
    @prediction = user.predictions.of_match(match).first_or_initialize
  end

  def update(left_team_score, right_team_score)
    # TODO validations
    @prediction.update(left_team_score: left_team_score, right_team_score: right_team_score)
  end
end
