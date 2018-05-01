class AddPointsMatchAverageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :points_match_average, :integer, null: true
  end
end
