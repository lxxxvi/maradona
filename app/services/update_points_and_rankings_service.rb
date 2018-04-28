class UpdatePointsAndRankingsService
  attr_reader :match

  def initialize(match = nil)
    @match = match
  end

  def run!
    update_match_prediction_points
    UpdateUsersPointsService.new.run!
    UpdateRankingsService.new.run!
  end

  def update_match_prediction_points
    return unless match.present?

    match.predictions.each do |prediction|
      actual_scores = {
        left_team_score: @match.left_team_score,
        right_team_score: @match.right_team_score
      }
      predicted_scores = {
        left_team_score: prediction.left_team_score,
        right_team_score: prediction.right_team_score
      }

      service = PredictionEvaluationService.new(actual_scores, predicted_scores)
      prediction.update(service.prediction_params)
    end
  end
end
