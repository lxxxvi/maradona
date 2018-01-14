class Match < ApplicationRecord
  belongs_to :venue
  belongs_to :left_team , class_name: 'Team', foreign_key: :left_team_id
  belongs_to :right_team, class_name: 'Team', foreign_key: :right_team_id

  has_many :predictions

  scope :with_predictions_of_user, -> (user) {
    includes(:predictions).where(predictions: { user_id: user.id })
  }

  scope :ordered_by_kickoff_at, -> { order(:kickoff_at) }
end
