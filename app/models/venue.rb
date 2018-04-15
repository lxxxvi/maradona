class Venue < ApplicationRecord
  scope :ordered, -> { order(:name) }

  def name_with_city
    "#{name} (#{city})"
  end
end
