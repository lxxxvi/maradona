class SquadsController < ApplicationController
  def index
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

  private

  def squad_params
    params.require(:squad).permit(:name)
  end

  def find_squad
    @squad = Squad.find(param[:id])
  end
end
