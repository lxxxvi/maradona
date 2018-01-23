class MatchPredictionUpdaterService
  attr_reader :prediction

  Response = Struct.new(:status, :messages, :payload)

  def initialize(match, user)
    @prediction = user.predictions.of_match(match).first_or_initialize
  end

  def update(left_team_score, right_team_score)
    if @prediction
        .update(left_team_score: left_team_score,
                right_team_score: right_team_score)
      response(:ok, ['Updated successfully'], { matchId: @prediction.match_id, newScores: @prediction.predicted_scores })
    else
      response(:error, @prediction.errors.to_a, { matchId: @prediction.match_id })
    end
  end

  private

  def response(status, messages, payload)
    Response.new(status, messages, payload)
  end
end
