class Squad < ApplicationRecord
  has_many :squad_members
  has_one  :coach_member          , -> { coaches } , class_name: 'SquadMember'
  scope :ordered, -> { order(:name) }

  scope :accepted_of_user, -> (user) {
    squad_ids = SquadMember.of_user(user).accepted.pluck(:squad_id)
    where(id: squad_ids)
  }

  scope :invited_of_user, -> (user) {
    squad_ids = SquadMember.of_user(user).invited.pluck(:squad_id)
    where(id: squad_ids)
  }

  before_validation :set_parameterized_name

  validates_presence_of   :name, :parameterized_name
  validates_uniqueness_of :name, :parameterized_name

  def to_param
    self.parameterized_name
  end

  private

  def set_parameterized_name
    self.parameterized_name = self.name.parameterize
  end
end
