class Admin::Matches::FinalScoresController < Admin::BaseController
  before_action :set_match, only: [:new, :create]

  def new
  end

  def create
    if @match.update(match_params)
      do_the_math
      flash[:notice] = 'Final score set successfully.'
      redirect_to [:admin, @match]
    else
      render :new
    end
  end

  private

  def match_params
    params.require(:match).permit(:left_team_score, :right_team_score)
  end

  def set_match
    @match ||= Match.find(params[:match_id])
  end

  def do_the_math
    @match.predictions.each do |prediction|
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
    UpdateUsersPointsService.new.run!
    RankService.new.run!
  end
end
