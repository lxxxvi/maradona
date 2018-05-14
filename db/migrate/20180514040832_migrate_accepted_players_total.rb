class MigrateAcceptedPlayersTotal < ActiveRecord::Migration[5.2]
  def change
    Squad.all.each do |squad|
      accepted_players_total = squad.squad_members.accepted.count
      squad.update(accepted_players_total: accepted_players_total)
    end
  end
end
