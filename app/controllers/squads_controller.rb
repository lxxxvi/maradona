class SquadsController < ApplicationController
  def index
    @new_squad = Squad.new
  end

  def show
    @squad = find_squad
  end

  def create
    @squad = Squad.new(squad_params)

    if @squad.save
      redirect_to @squad, notice: 'Squad created'
    else
      render :index
    end
  end

  def edit
    @squad = find_squad
  end

  private

  def squad_params
    params.require(:squad).permit(:name)
  end

  def find_squad
    @squad = Squad.find(params[:id])
  end
end
