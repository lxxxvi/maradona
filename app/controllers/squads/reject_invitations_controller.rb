class Squads::RejectInvitationsController < ApplicationController
  before_action :set_squad
  before_action :set_squad_member

  def create
    authorize @squad_member, :reject_invitation?
    @squad_member.reject_invitation!
    redirect_to authenticated_root_path
  end

  private

  def set_squad_member
    @squad_member ||= policy_scope(SquadMember).find_by(squad: @squad)
  end

  def set_squad
    @squad ||= Squad.find_by(parameterized_name: params[:squad_parameterized_name])
  end
end
