class MigrateInvitationKeyOnSquad < ActiveRecord::Migration[5.2]
  def up
    Squad.where(invitation_key: nil).find_each do |squad|
      squad.invitation_key = SecureRandom.alphanumeric(32)
      squad.save!
    end
  end

  def down
    Squad.where.not(invitation_key: nil).update_all(invitation_key: nil)
  end
end
