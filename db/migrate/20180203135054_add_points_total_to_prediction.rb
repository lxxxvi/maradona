class AddPointsTotalToPrediction < ActiveRecord::Migration[5.1]
  def change
    add_column :predictions, :points_total, :integer, null: true
  end
end
