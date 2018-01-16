class MatchesController < ApplicationController
  def index
    @matches_with_predictions = find_matches_with_predictions
  end

  private

  def find_matches_with_predictions
    service_for_current_user.matches_with_predictions
  end

  def service_for_current_user
    MatchPredictionCollectionService.new(current_user)
  end
end
