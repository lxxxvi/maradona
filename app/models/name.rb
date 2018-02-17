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
      Name.random_first_name,
      Name.random_last_name
    ].join('.')
  end

  private
  def self.random_first_name
    Name.first_name
      .sampled
      .first
      .value
  end

  def self.random_last_name
    Name.last_name
      .sampled
      .first
      .value
  end
end
