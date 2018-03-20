class UsersController < ApplicationController
  before_action :set_user

  def show
    return not_found if @user.nil?
  end

  private

  def set_user
    if params[:player_id].present?
      @user ||= User.find_by(player_id: params[:player_id])
    else
      @user = current_user
    end
  end
end
