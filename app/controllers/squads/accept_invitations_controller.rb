class Squads::AcceptInvitationsController < ApplicationController
  before_action :set_squad
  before_action :set_squad_member

  def create
    authorize @squad_member, :accept_invitation?
    @squad_member.accept_invitation!
    redirect_to squad_path(@squad)
  end

  private

  def set_squad_member
    @squad_member ||= policy_scope(SquadMember).find_by(squad: @squad)
  end

  def set_squad
    @squad ||= Squad.find_by(parameterized_name: params[:squad_parameterized_name])
  end
end
