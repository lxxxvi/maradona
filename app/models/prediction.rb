class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  scope :of_match, -> (match) { where(match: match) }

  def predicted?
    created_at.present?
  end

  def predictable?
    match.kickoff_at > Time.zone.now
  end

  def points_sum
    return unless points_evaluated?

    points_left_team_score +
    points_right_team_score +
    points_overall_outcome +
    points_goal_difference
  end

  def points_evaluated?
    points_left_team_score &&
    points_right_team_score &&
    points_overall_outcome &&
    points_goal_difference
  end
end
