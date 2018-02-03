class AddPointsTotalToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :points_total, :integer, null: true
  end
end
