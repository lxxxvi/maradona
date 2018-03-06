class Squad < ApplicationRecord
  has_many :squad_members
  has_one :admin_member, -> { admins }, class_name: 'SquadMember'
  scope :ordered, -> { order(:name) }
  scope :of_user, -> (user) {
    includes(:squad_members)
      .where(squad_members: { user: user })
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
