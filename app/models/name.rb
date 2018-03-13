class Name < ApplicationRecord
  enum part: [:first_name, :last_name]
  validates_presence_of :value, :part

  scope :sampled, lambda {
    count = Name.count
    random = rand(0...count)
    offset(random)
  }

  def self.unique_random_nickname
    random_number = nil

    3.times do
      nickname = Name.random_nickname(random_number)
      return nickname unless User.find_by(nickname: nickname).present?

      random_number = SecureRandom.rand(10_000..99_999)
    end

    raise 'Could not generate an unique random nickname after 3 attempts'
  end

  def self.random_nickname(number = nil)
    [
      Name.random_first_name,
      Name.random_last_name,
      number
    ].compact.join('.')
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
