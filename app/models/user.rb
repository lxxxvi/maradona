class User < ApplicationRecord
  has_many :predictions

  def collect_points!
    update(points_total: predictions.sum(:points_total))
  end
end
