class AddGroupLetterToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :group_letter, :string, null: true
  end
end
