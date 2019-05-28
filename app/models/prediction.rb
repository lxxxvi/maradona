class Prediction < ApplicationRecord
  belongs_to :game

  validates :left_team_score,
            numericality: { greater_than_or_equal_to: 0 }
  validates :right_team_score,
            numericality: { greater_than_or_equal_to: 0 }
  validate :kickoff_at_in_future

  def previous_score_changes
    previous_changes.slice('left_team_score', 'right_team_score').map do |score, from_to|
      {
        score: score,
        from: from_to.first,
        to: from_to.last
      }
    end
  end

  private

  def kickoff_at_in_future
    errors.add(:base, "The games' kickoff must be in the future") unless game.kickoff_at.future?
  end
end
