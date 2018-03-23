class Squad < ApplicationRecord
  has_many :squad_members
  has_one  :coach_member          , -> { coaches } , class_name: 'SquadMember'
  has_many :accepted_squad_members, -> { accepted }, class_name: 'SquadMember'
  has_many :invited_squad_members , -> { invited } , class_name: 'SquadMember'
  has_many :rejected_squad_members, -> { rejected }, class_name: 'SquadMember'
  scope :ordered, -> { order(:name) }

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
