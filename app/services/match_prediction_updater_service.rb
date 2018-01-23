class MatchPredictionUpdaterService
  attr_reader :prediction

  Response = Struct.new(:status, :messages, :payload)

  def initialize(match, user)
    @prediction = user.predictions.of_match(match).first_or_initialize
  end

  def update(left_team_score, right_team_score)
    if @prediction.update(left_team_score: left_team_score, right_team_score: right_team_score)
      response(:ok, ['Updated successfully'], payload)
    else
      response(:error, @prediction.errors.to_a, payload)
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
end
