class Squad::MemberInvitationForm
  include ActiveModel::Model
  attr_reader :squad, :nickname

  validates_presence_of :nickname
  validate :user_with_nickname_exists
  validate :user_not_member_of_squad_already

  def initialize(squad, params = {})
    @squad = squad
    @nickname = params.values_at(:nickname)
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
      errors.add(:nickname, 'already member of squad')
    end
  end

  def user_with_nickname_exists
    unless find_user.present?
      errors.add(:nickname, 'does not exist')
    end
  end

  def find_user
    @user ||= User.find_by(nickname: nickname)
  end
end
