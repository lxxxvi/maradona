class BookiesController < ApplicationController
  def index
    @matches_with_predictions = Match.with_predictions_of_user(current_user).ordered_by_kickoff_at
  end

  private

  def current_user
    User.first
  end
end
