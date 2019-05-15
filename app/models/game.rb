class Game < ApplicationRecord
  has_many :predictions, dependent: :destroy

  scope :ordered_by_kickoff, -> { order(kickoff_at: :asc) }

  validates :tournament_stage, :kickoff_at,
            :left_team, :right_team, presence: true
  validates :left_team_score,
            numericality: { greater_than_or_equal_to: 0 },
            if: :score_present?
  validates :right_team_score,
            numericality: { greater_than_or_equal_to: 0 },
            if: :score_present?

  def user_prediction
    predictions.first_or_initialize
  end

  def score_present?
    left_team_score.present? || right_team_score.present?
  end
end
