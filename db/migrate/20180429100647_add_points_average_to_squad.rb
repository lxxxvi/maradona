class AddPointsAverageToSquad < ActiveRecord::Migration[5.2]
  def change
    add_column :squads, :points_average, :integer, null: true, default: 0
  end
end
