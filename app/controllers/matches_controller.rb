class MatchesController < ApplicationController
  def index
    @upcoming_matches = []
    @finished_matches = []

    find_matches_with_predictions.each do |match_with_prediction|
      if match_with_prediction.match.no_scores?
        @upcoming_matches << match_with_prediction
      else
        @finished_matches.prepend(match_with_prediction)
      end
    end
  end

  private

  def find_matches_with_predictions
    service_for_current_user.matches_with_predictions
  end

  def service_for_current_user
    MatchPredictionCollectionService.new(current_user)
  end
end
