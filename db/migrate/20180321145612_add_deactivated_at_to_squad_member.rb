class AddDeactivatedAtToSquadMember < ActiveRecord::Migration[5.1]
  def change
    add_column :squad_members, :deactivated_at, :datetime, null: true
  end
end
