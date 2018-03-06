class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :edit, :update]

  def index
    @squads = Squad.of_user(current_user).ordered
  end

  def new
    @squad = Squad.new
  end

  def show
  end

  def create
    @squad = Squad.new(squad_params)
    @squad.squad_members.new(
      user: current_user,
      invitation_sent_at: Time.zone.now,
      invitation_accepted_at: Time.zone.now,
      admin: true
    )

    if @squad.save
      redirect_to @squad, notice: 'Squad created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @squad.update(squad_params)
      redirect_to @squad, notice: 'Squad updated'
    else
      render :edit
    end
  end

  private

  def squad_params
    params.require(:squad).permit(:name)
  end

  def set_squad
    @squad = Squad.find(params[:id])
  end
end
