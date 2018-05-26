class Squad::MemberInvitationForm
  include ActiveModel::Model
  attr_reader :squad, :player_id

  validates_presence_of :player_id
  validate :user_with_player_id_exists
  validate :user_not_member_of_squad_already

  def initialize(squad, params = {})
    @squad = squad
    @player_id = params[:player_id]&.chomp
  end

  def squad_member
    squad.squad_members.new(user: find_user, invitation_sent_at: Time.zone.now)
  end

  def model_name
    ActiveModel::Name.new(self, nil, 'Squad::MemberInvitation')
  end

  private

  def user_not_member_of_squad_already
    if squad.squad_members.find_by(user: find_user).present?
      errors.add(:player_id, 'already member of squad')
    end
  end

  def user_with_player_id_exists
    unless find_user.present?
      errors.add(:player_id, 'does not exist')
    end
  end

  def find_user
    @user ||= User.active.find_by(player_id: player_id)
  end
end
