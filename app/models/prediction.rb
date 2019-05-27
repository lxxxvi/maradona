class Prediction < ApplicationRecord
  belongs_to :game

  validates :left_team_score,
            numericality: { greater_than_or_equal_to: 0 }
  validates :right_team_score,
            numericality: { greater_than_or_equal_to: 0 }
  validate :kickoff_at_in_future

  private

  def kickoff_at_in_future
    errors.add(:base, "The games' kickoff must be in the future") unless game.kickoff_at.future?
  end
end
