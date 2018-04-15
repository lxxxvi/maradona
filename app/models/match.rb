class Match < ApplicationRecord
  belongs_to :venue
  belongs_to :left_team , class_name: 'Team', foreign_key: :left_team_id
  belongs_to :right_team, class_name: 'Team', foreign_key: :right_team_id
  has_many :predictions

  enum phase: {
    group_stage: 'Group stage',
    round_of_sixteen: 'Round of 16',
    quarter_finals: 'Quarter-finals',
    semi_finals: 'Semi-finals',
    third_place: 'Third place play-off',
    final: 'Final'
  }

  scope :ordered, -> { order(kickoff_at: :asc) }

  validates_presence_of :phase, :left_team, :right_team, :venue, :kickoff_at
  validate :right_team_is_not_same_as_left_team
  validate :uniqueness_of_match_in_phase

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

  private

  def right_team_is_not_same_as_left_team
    if right_team == left_team
      errors.add(:right_team, 'cannot be same as left team')
    end
  end

  def uniqueness_of_match_in_phase
    if Match.where.not(id: id).where(phase: phase, left_team: left_team, right_team: right_team).any?
      errors.add(:base, 'Match already exists in same phase')
    end
  end
end
