class Users::NicknamesController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
    authorize @user, :edit?
  end

  def update
    authorize @user, :update?

    if @user.update(user_params)
      redirect_to authenticated_root_path, notice: 'Nickname updated'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(player_id: params[:user_player_id])
  end

  def user_params
    params.require(:user).permit(:nickname)
  end
end
