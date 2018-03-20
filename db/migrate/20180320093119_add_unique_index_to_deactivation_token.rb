class AddUniqueIndexToDeactivationToken < ActiveRecord::Migration[5.1]
  def change
    add_index :users, [:deactivation_token], name: 'uk_users_deactivation_token', unique: true
  end
end
