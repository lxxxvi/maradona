class AddIndexOnInvitationKeyOnTeam < ActiveRecord::Migration[5.2]
  def change
    add_index :squads, [:invitation_key], unique: true, name: 'ak_squads_invitation_key'
  end
end
