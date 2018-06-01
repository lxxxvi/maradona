class Squad < ApplicationRecord
  has_many :squad_members
  has_one  :coach_member          , -> { coaches } , class_name: 'SquadMember'
  scope :ordered, -> { order(:name) }

  before_validation :set_parameterized_name
  before_validation :set_invitation_key

  validates_presence_of   :name, :parameterized_name, :invitation_key
  validates_uniqueness_of :name, :parameterized_name, :invitation_key

  def to_param
    self.parameterized_name
  end

  private

  def set_parameterized_name
    self.parameterized_name = self.name.parameterize
  end

  def set_invitation_key
    self.invitation_key ||= SecureRandom.alphanumeric(32)
  end
end
