class UsersController < ApplicationController
  before_action :set_user

  def show
    return not_found if @user.nil?
  end

  private

  def set_user
    if params[:nickname].present?
      @user ||= User.find_by(nickname: params[:nickname])
    else
      @user = current_user
    end
  end
end
