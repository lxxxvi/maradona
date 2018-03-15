class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  before_action :count_invitations
  protect_from_forgery with: :exception, prepend: true

  def count_invitations
    return unless current_user.present?
    @invitation_count = current_user.squad_members.invited.count
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
