class MigrateInvitationKeyOnSquad < ActiveRecord::Migration[5.2]
  def up
    raise 'TOOD: fixme'
    Squad.where(invitation_key: nil).find_each do |squad|
      squad.invitation_key = SecureRandom.alphanumeric(32)
      squad.save!
    end
  end
end
