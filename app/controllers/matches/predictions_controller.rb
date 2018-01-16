class Matches::PredictionsController < ApplicationController
  before_action :find_or_initialize_prediction

  def new
  end

  def create
    if @prediction.update(prediction_params)
      redirect_to root_path
    else
      flash[:danger] = 'Wrong input'
      render :new
    end
  end

  private

  def prediction_params
    params.require(:prediction).permit(:left_team_score, :right_team_score)
  end

  def find_or_initialize_prediction
    @prediction ||= prediction_for_current_user
    @prediction.left_team_score  ||= 0
    @prediction.right_team_score ||= 0
  end
  end

  def find_match
    @match ||= Match.find(params[:match_id])
  end

  def prediction_for_current_user
    current_user
      .predictions
      .of_match(find_match)
      .first_or_initialize
  end
end
