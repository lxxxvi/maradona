class ChangeInvitationKeyToNotNullOnTeam < ActiveRecord::Migration[5.2]
  def change
    change_column :squads, :invitation_key, :string, null: false
  end
end
