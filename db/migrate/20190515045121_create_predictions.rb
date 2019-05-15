class CreatePredictions < ActiveRecord::Migration[6.0]
  def change
    create_table :predictions do |t|
      t.references :game, null: false
      t.integer :left_team_score
      t.integer :right_team_score
    end
  end
end
