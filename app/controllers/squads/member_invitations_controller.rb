class Squads::MemberInvitationsController < ApplicationController
  before_action :set_squad, only: [:new, :create]

  def new
    @member_invitation_form = Squad::MemberInvitationForm.new(@squad)
  end

  def create
  end

  private

  def set_squad
    @squad = Squad.find_by(parameterized_name: params[:squad_parameterized_name])
  end
end
