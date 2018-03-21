class SquadMember < ApplicationRecord
  belongs_to :squad
  belongs_to :user

  scope :active           , -> { where(deactivated_at: nil) }
  scope :inactive         , -> { where.not(deactivated_at: nil) }
  scope :of_user          , -> (user) { active.where(user: user) }
  scope :ordered          , -> { includes(:user).order('users.player_id ASC') }
  scope :coaches          , -> { active.where(coach: true) }
  scope :accepted         , -> { active.where.not(invitation_accepted_at: nil) }
  scope :not_accepted     , -> { active.where(invitation_accepted_at: nil) }
  scope :rejected         , -> { active.where.not(invitation_rejected_at: nil) }
  scope :not_rejected     , -> { active.where(invitation_rejected_at: nil) }
  scope :canceled         , -> { active.where.not(invitation_canceled_at: nil) }
  scope :not_canceled     , -> { active.where(invitation_canceled_at: nil) }
  scope :invited          , -> { active.not_accepted.not_rejected.not_canceled }

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

  def deactivate!
    update(deactivated_at: Time.zone.now)
  end
end
