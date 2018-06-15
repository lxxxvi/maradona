class ChangeRankingPositionToNullableOnUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :ranking_position, :integer, null: true, default: nil
  end

  def down
    change_column :users, :ranking_position, :integer, null: false, default: 0
  end
end
