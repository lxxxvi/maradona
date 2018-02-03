class RemoveGroupIdFromTeam < ActiveRecord::Migration[5.1]
  def up
    remove_column :teams, :group_id
  end
end
