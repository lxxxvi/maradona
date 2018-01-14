class Match < ApplicationRecord
  belongs_to :venue
  belongs_to :left_team , class_name: 'Team', foreign_key: :left_team_id
  belongs_to :right_team, class_name: 'Team', foreign_key: :right_team_id
  has_many :predictions
end
