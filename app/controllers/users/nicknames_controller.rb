class Users::NicknamesController < ApplicationController
  def edit
    @user = current_user
    authorize @user, :edit?
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to authenticated_root_path, notice: 'Nickname updated'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end
end
