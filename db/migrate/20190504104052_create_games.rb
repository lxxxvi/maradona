class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :tournament_stage, null: false
      t.timestamp :kickoff_at, null: false
      t.string :left_team, null: false
      t.string :right_team, null: false
      t.integer :left_team_score, null: true
      t.integer :right_team_score, null: true

      t.timestamps
    end
  end
end
