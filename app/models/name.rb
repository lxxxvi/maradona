class Name < ApplicationRecord
  enum part: [:first_name, :last_name]
  validates_presence_of :value, :part

  scope :sampled, lambda {
    count = Name.count
    random = rand(0...count)
    offset(random)
  }

  def self.unique_random_player_id
    3.times do
      player_id = Name.random_player_id
      return player_id unless User.find_by(player_id: player_id).present?
    end

    raise 'Could not generate an unique random player_id after 3 attempts'
  end

  def self.random_player_id
    [
      Name.random_first_name,
      Name.random_last_name,
      rand(10_000..99_999)
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
