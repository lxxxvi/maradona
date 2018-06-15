class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :predictions
  has_many :predicted_matches, through: :predictions, source: :match

  has_many :squad_members
  has_many :squad_accepts     , -> { accepted }, class_name: 'SquadMember'
  has_many :squad_invitations , -> { invited } , class_name: 'SquadMember'
  has_many :squads, through: :squad_accepts

  scope :ordered, -> { order(nickname: :asc) }
  scope :ordered_by_ranking, -> { order(ranking_position: :asc) }
  scope :active, -> { where(deactivated_at: nil) }
  scope :inactive, -> { where.not(deactivated_at: nil) }

  before_validation :assign_random_player_id
  before_validation :initialize_nickname
  before_create :assign_new_deactivation_token

  validates_presence_of   :player_id, :nickname
  validates_uniqueness_of :player_id, :nickname

  def collect_points!
    evaluate_predictions!
    update(points_total: predictions.sum(:points_total))
  end

  def to_param
    self.player_id
  end

  def unpredicted_matches
    Match.upcoming.where.not(id: self.predictions.pluck(:match_id))
  end

  def deactivate!
    self.transaction do
      self.deactivated_at = Time.zone.now
      assign_new_deactivation_token
      self.squad_members.each do |squad_member|
        squad_member.deactivate!
      end
      save!
    end
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

  def assign_new_deactivation_token
    self.deactivation_token = SecureRandom.alphanumeric(64)
  end

  def initialize_nickname
    self.nickname ||= self.player_id
  end
end
