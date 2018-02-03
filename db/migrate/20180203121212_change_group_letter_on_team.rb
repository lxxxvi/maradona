class ChangeGroupLetterOnTeam < ActiveRecord::Migration[5.1]
  def up
    change_column :teams, :group_letter, :string, null: false
  end

  def down
    change_column :teams, :group_letter, :string, null: true
  end
end
