class JoinByKeysController < ApplicationController
  before_action :set_squad

  def new
    if @squad.present?
      squad_member = @squad.squad_members.find_or_initialize_by(user: current_user)

      unless squad_member.accepted?
        squad_member.invitation_sent_at = Time.zone.now
        squad_member.accept_invitation!
      end

      redirect_to squad_path(@squad)
    else
      redirect_to authenticated_root_path, notice: "Not possible to join squad, did you use the right link?"
    end
  end

  def set_squad
    @squad = Squad.find_by(invitation_key: params[:invitation_key])
  end
end
