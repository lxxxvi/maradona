class Admin::Matches::FinalScoresController < Admin::BaseController
  before_action :set_match, only: [:new, :create]

  def new
  end

  def create
    if @match.update(match_params)
      UpdatePointsAndRankingsService.new(@match).run!
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
end
