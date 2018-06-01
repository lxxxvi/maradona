class AddInvitationKeyToSquad < ActiveRecord::Migration[5.2]
  def change
    add_column :squads, :invitation_key, :string, null: true
  end
end
