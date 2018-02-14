class Name < ApplicationRecord
  enum part: [:first_name, :last_name]
  validates_presence_of :value, :part

  scope :sampled, lambda {
    count = Name.count
    random = rand(0...count)
    offset(random)
  }

  def self.random_nickname
    [
      Name.first_name.sampled.first,
      Name.last_name.sampled.first
    ].join('.')
  end
end
