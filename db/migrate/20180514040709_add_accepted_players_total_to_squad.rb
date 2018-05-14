class AddAcceptedPlayersTotalToSquad < ActiveRecord::Migration[5.2]
  def change
    add_column :squads, :accepted_players_total, :integer, null: false, default: 1
  end
end
