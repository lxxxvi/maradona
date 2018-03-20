class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :predictions
  has_many :predicted_matches, through: :predictions, source: :match

  has_many :squad_accepts     , -> { accepted }, class_name: 'SquadMember'
  has_many :squad_invitations , -> { invited } , class_name: 'SquadMember'
  has_many :squads, through: :squad_accepts

  scope :ordered_by_ranking, -> { order(ranking_position: :asc) }

  before_create :assign_random_player_id

  def collect_points!
    evaluate_predictions!
    update(points_total: predictions.sum(:points_total))
  end

  def to_param
    self.player_id
  end

  def unpredicted_matches
    Match.where.not(id: self.predictions.pluck(:match_id))
  end

  private

  def evaluate_predictions!
    predictions.evaluable.each do |prediction|
      prediction.collect_points!
    end
  end

  def assign_random_player_id
    self.player_id ||= Name.unique_random_player_id
  end
end
