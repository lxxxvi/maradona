class Team < ApplicationRecord
  scope :ordered, -> { order(:name) }

  def name_with_code
    "#{name} (#{fifa_country_code})"
  end
end
