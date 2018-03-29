class Admin::MatchesController < Admin::BaseController
  before_action :set_match, only: [:show, :edit, :update]

  def index
    @matches = Match.ordered
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      flash[:notice] = 'Match added successfully.'
      redirect_to [:admin, @match]
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @match.update(match_params)
      flash[:notice] = 'Match updated successfully.'
      redirect_to [:admin, @match]
    else
      render :edit
    end
  end

  private

  def match_params
    params.require(:match).permit(:phase, :left_team_id, :right_team_id, :venue_id, :kickoff_at, :left_team_score, :right_team_score)
  end

  def set_match
    @match = Match.find(params[:id])
  end
end
