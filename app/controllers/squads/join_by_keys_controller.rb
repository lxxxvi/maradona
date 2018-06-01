class Squads::JoinByKeysController < ApplicationController
  before_action :set_squad

  def new
    if @squad.invitation_key == params[:invitation_key]
      squad_member = @squad.squad_members.find_or_initialize_by(user: current_user)

      unless squad_member.accepted?
        squad_member.invitation_sent_at = Time.zone.now
        squad_member.accept_invitation!
      end

      redirect_to squad_path(@squad)
    else
      redirect_to authenticated_root_path, notice: "Not possible to join #{@squad.name}, did you use the right link?"
    end
  end

  def set_squad
    @squad = Squad.find_by(parameterized_name: params[:squad_parameterized_name])
  end
end
