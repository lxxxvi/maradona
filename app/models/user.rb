class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :predictions

  scope :ordered_by_ranking, -> { order(ranking_position: :asc) }

  before_create :assign_random_nickname

  def collect_points!
    evaluate_predictions!
    update(points_total: predictions.sum(:points_total))
  end

  private
  def evaluate_predictions!
    predictions.evaluable.each do |prediction|
      prediction.collect_points!
    end
  end

  def assign_random_nickname
    self.nickname ||= Name.random_nickname
  end
end
