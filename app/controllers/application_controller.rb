class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception, prepend: true

  # def current_user
  #   User.first
  # end
end
