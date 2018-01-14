class CreatePrediction < ActiveRecord::Migration[5.1]
  def change
    create_table :predictions do |t|
      t.references :user,   foreign_key: true
      t.references :match,  foreign_key: true

      t.column :left_team_score,          :integer, null: true
      t.column :right_team_score,         :integer, null: true
      t.column :points_left_team_score,   :integer, null: true
      t.column :points_right_team_score,  :integer, null: true
      t.column :points_overall_outcome,   :integer, null: true
      t.column :points_goal_difference,   :integer, null: true

      t.timestamps
    end

    add_index :predictions, [:user_id, :match_id]
  end
end
