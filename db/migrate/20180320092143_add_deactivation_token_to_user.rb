class AddDeactivationTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :deactivation_token, :string, null: true
  end
end
