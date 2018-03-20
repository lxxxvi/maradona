class Squads::MemberInvitationsController < ApplicationController
  before_action :set_squad, only: [:new, :create]

  def new
    authorize @squad, :invite_member?
    @member_invitation_form = Squad::MemberInvitationForm.new(@squad)
  end

  def create
    authorize @squad, :invite_member?
    @member_invitation_form = Squad::MemberInvitationForm.new(@squad, squad_member_invitation_params)

    if @member_invitation_form.valid?
      @member_invitation_form.squad_member.save!

      redirect_to squad_path(@squad), notice: 'Invitation has been sent'
    else
      render :new
    end
  end

  private

  def squad_member_invitation_params
    params.require(:squad_member_invitation).permit(:player_id)
  end

  def set_squad
    @squad = Squad.find_by(parameterized_name: params[:squad_parameterized_name])
  end
end
