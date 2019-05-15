class Prediction < ApplicationRecord
  belongs_to :game

  validates :left_team_score,
            numericality: { greater_than_or_equal_to: 0 },
            if: :score_present?
  validates :right_team_score,
            numericality: { greater_than_or_equal_to: 0 },
            if: :score_present?

  def score_present?
    left_team_score.present? || right_team_score.present?
  end
end
