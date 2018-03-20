class DeactivationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    user = User.find_by!(deactivation_token: params[:token])
    user.deactivate!
  end
end
