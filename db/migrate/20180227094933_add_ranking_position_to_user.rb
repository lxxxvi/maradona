class AddRankingPositionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ranking_position, :integer, null: false, default: 0
  end
end
