class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  protect_from_forgery with: :exception, prepend: true

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
