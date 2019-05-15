class Prediction < ApplicationRecord
  belongs_to :game

  validates :left_team_score,
            numericality: { greater_than_or_equal_to: 0 }
  validates :right_team_score,
            numericality: { greater_than_or_equal_to: 0 }
end
