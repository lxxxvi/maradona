class MatchPredictionUpdaterService
  attr_reader :prediction, :match

  Response = Struct.new(:status, :messages, :payload)

  def initialize(match, user)
    @match = match
    @prediction = user.predictions.of_match(match).first_or_initialize
  end

  def update(left_team_score, right_team_score)
    prediction.assign_attributes(
      left_team_score: left_team_score,
      right_team_score: right_team_score
    )
    if prediction_valid? && prediction.save
      response(:ok, ['Updated successfully'], payload)
    else
      response(:error, prediction.errors.to_a, payload)
    end
  end

  private

  def response(status, messages, payload)
    Response.new(status, messages, payload)
  end

  def payload
    {
      match_id: @prediction.match_id,
      left_team_score: @prediction.left_team_score,
      right_team_score: @prediction.right_team_score
    }
  end

  def prediction_valid?
    prediction.valid?
    if deadline_for_prediction_passed?
      prediction.errors.add(:base, "Oh no, you're too late to predict that game")
    end
    prediction.errors.none?
  end

  def deadline_for_prediction_passed?
    match.kickoff_at <= Time.zone.now
  end
end
