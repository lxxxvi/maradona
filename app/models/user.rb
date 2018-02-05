class User < ApplicationRecord
  has_many :predictions

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
end
