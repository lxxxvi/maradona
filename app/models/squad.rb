class Squad < ApplicationRecord
  has_many :squad_members
  has_one :admin_member, -> { admins }, class_name: 'SquadMember'
  scope :ordered, -> { order(:name) }
  scope :of_user, -> (user) {
    includes(:squad_members)
      .where(squad_members: { user: user })
  }
end
