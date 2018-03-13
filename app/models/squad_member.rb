class SquadMember < ApplicationRecord
  belongs_to :squad
  belongs_to :user

  scope :of_user      , -> (user) { where(user: user) }
  scope :ordered      , -> { includes(:user).order('users.nickname ASC') }
  scope :coaches      , -> { where(coach: true) }
  scope :accepted     , -> { where.not(invitation_accepted_at: nil) }
  scope :not_accepted , -> { where(invitation_accepted_at: nil) }
  scope :rejected     , -> { where.not(invitation_rejected_at: nil) }
  scope :not_rejected , -> { where(invitation_rejected_at: nil) }
  scope :canceled     , -> { where.not(invitation_canceled_at: nil) }
  scope :not_canceled , -> { where(invitation_canceled_at: nil) }
  scope :invited      , -> { not_accepted.not_rejected.not_canceled }

  def accept_invitation!
    update({
      invitation_accepted_at: Time.zone.now,
      invitation_rejected_at: nil
    })
  end

  def reject_invitation!
    update({
      invitation_accepted_at: nil,
      invitation_rejected_at: Time.zone.now
    })
  end
end
