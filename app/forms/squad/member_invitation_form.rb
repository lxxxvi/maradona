class Squad::MemberInvitationForm
  attr_reader :squad

  def initialize(squad, params = {})
    @squad = squad
  end

  def model_name
    'SquadMemberInvitation'
  end
end
