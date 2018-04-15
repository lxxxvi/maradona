class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate_admin!, only: [:new, :create]

  def new
    redirect_to admin_root_path if admin_signed_in?
  end

  def create
    if password_correct?
      signin_admin
      redirect_to admin_matches_path, notice: 'Signed in successfully.'
    else
      flash[:alert] = 'Invalid password'
      render :new
    end
  end

  def destroy
    sign_out_admin
    redirect_to admin_sign_in_path, notice: 'Signed out successfully.'
  end

  private

  def password_correct?
    session_params[:password].present? && 
    Rails.application.secrets.admin_password == session_params[:password]
  end

  def session_params
    params.require(:session).permit(:password)
  end
end
