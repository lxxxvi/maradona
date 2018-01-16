class BookiesController < ApplicationController
  def index
    @matches_with_predictions = BookiesService.new(current_user).matches_with_predictions
  end
end
