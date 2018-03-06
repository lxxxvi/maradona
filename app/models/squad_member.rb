class SquadMember < ApplicationRecord
  belongs_to :squad
  belongs_to :user

  scope :ordered , -> { includes(:user).order('users.nickname ASC') }
  scope :coaches , -> { where(coach: true) }
  scope :accepted, -> { where.not(invitation_accepted_at: nil) }
  scope :invited , -> { where(invitation_accepted_at: nil) }
end
