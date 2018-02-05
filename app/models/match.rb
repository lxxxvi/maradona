class Match < ApplicationRecord
  belongs_to :venue
  belongs_to :left_team , class_name: 'Team', foreign_key: :left_team_id
  belongs_to :right_team, class_name: 'Team', foreign_key: :right_team_id
  has_many :predictions

  def score
    return unless finished?
    {
      left_team_score: self.left_team_score,
      right_team_score: self.right_team_score
    }
  end

  def finished?
    left_team_score.present? &&
    right_team_score.present?
  end
end
