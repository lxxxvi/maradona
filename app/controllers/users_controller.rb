class UsersController < ApplicationController
  before_action :set_user

  def show
    return not_found if @user.nil?
  end

  private

  def set_user
    if player_id_in_params_and_not_current_user
      @user ||= User.active.find_by(player_id: params[:player_id])
    else
      @user = current_user
    end
  end

  def player_id_in_params_and_not_current_user
    params[:player_id].present? &&
    params[:player_id] != current_user.id
  end
end
