class SquadMember < ApplicationRecord
  belongs_to :squad
  belongs_to :user

  scope :ordered, -> {
    includes(:user)
      .order('users.nickname ASC')
  }

  scope :admins, -> {
    where(admin: true)
  }
end
