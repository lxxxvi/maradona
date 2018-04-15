class Admin::BaseController < ActionController::Base
  before_action :authenticate_admin!
  protect_from_forgery with: :exception, prepend: true
  helper_method :admin_signed_in?
  layout 'admin/application'

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to new_admin_sessions_path, notice: 'Please sign in'
    end
  end

  def admin_signed_in?
    session[:admin_signed_in] === true
  end

  def signin_admin
    session[:admin_signed_in] = true
  end

  def sign_out_admin
    session.clear
  end
end
