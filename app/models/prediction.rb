class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :left_team_score , numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :right_team_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :of_match, -> (match) { where(match: match) }

  def predicted?
    created_at.present?
  end

  def predictable?
    match.kickoff_at > Time.zone.now
  end

  def evaluated?
    self.points_total.present?
  end

  def evaluable?
    match.finished?
  end

  def score
    {
      left_team_score: self.left_team_score,
      right_team_score: self.right_team_score
    }
  end

  def collect_points!
    return unless evaluable?
    service = PredictionEvaluationService.new(match.score, self.score)
    self.update(service.prediction_params)
  end
end
