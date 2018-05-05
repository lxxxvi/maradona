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

  scope :invited_or_accepted, -> { invited.or(SquadMember.accepted) }

  def active?
    deactivated_at.nil?
  end

  def accepted?
    active? && invitation_accepted_at.present?
  end

  def canceled?
    active? && invitation_canceled_at.present?
  end

  def rejected?
    active? && invitation_rejected_at.present?
  end

  def invited?
    active? && !accepted? && !rejected? && !canceled?
  end

  def accept_invitation!
    self.transaction do
      update({
        invitation_accepted_at: Time.zone.now,
        invitation_rejected_at: nil
      })
      update_squads_points_and_rankings
    end
  end

  def reject_invitation!
    update({
      invitation_accepted_at: nil,
      invitation_rejected_at: Time.zone.now
    })
  end

  def deactivate!
    self.transaction do
      update(deactivated_at: Time.zone.now)
      update_squads_points_and_rankings
    end
  end

  def update_squads_points_and_rankings
    UpdateSquadMembersRankingsService.new(self.squad).run!
    UpdateSquadsPointsService.new(self.squad).run!
    UpdateSquadsRankingsService.new.run!
  end
end
