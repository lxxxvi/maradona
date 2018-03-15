class Name < ApplicationRecord
  enum part: [:first_name, :last_name]
  validates_presence_of :value, :part

  scope :sampled, lambda {
    count = Name.count
    random = rand(0...count)
    offset(random)
  }

  def self.unique_random_nickname
    3.times do
      nickname = Name.random_nickname
      return nickname unless User.find_by(nickname: nickname).present?
    end

    raise 'Could not generate an unique random nickname after 3 attempts'
  end

  def self.random_nickname
    [
      Name.random_first_name,
      Name.random_last_name,
      SecureRandom.rand(10_000..99_999)
    ].join('-')
  end

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
