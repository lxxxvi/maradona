class ChangeNicknameToNotNullOnUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :nickname, :string, null: false
    add_index :users, [:nickname], name: 'ak_users_nickname', unique: true
  end

  def down
    remove_index :users, name: 'ak_users_nickname'
    change_column :users, :nickname, :string, null: true
  end
end
