class RenameNicknameToPlayerIdOnUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :nickname, :player_id
  end
end
