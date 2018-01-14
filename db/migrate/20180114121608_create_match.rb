class CreateMatch < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references  :venue, foreign_key: true
      t.column      :left_team_id,      :integer,   null: false
      t.column      :right_team_id,     :integer,   null: false
      t.column      :phase,             :string,    null: false
      t.column      :left_team_score,   :integer,   null: true
      t.column      :right_team_score,  :integer,   null: true
      t.column      :kickoff_at,        :datetime,  null: false

      t.timestamps
    end

    add_foreign_key :matches, :teams, column: :left_team_id
    add_foreign_key :matches, :teams, column: :right_team_id

    add_index :matches, [:phase, :left_team_id, :right_team_id], unique: true
  end
end
