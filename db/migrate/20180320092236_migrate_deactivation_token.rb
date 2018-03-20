require 'digest/md5'

class MigrateDeactivationToken < ActiveRecord::Migration[5.1]
  def up
    initialize_deactivation_tokens
    change_column :users, :deactivation_token, :string, null: false
  end

  def down
    change_column :users, :deactivation_token, :string, null: true
  end

  private

  def initialize_deactivation_tokens
    User.where(deactivation_token: nil).find_each do |user|
      user.deactivation_token = random_string
      user.save!
    end
  end

  def random_string
    Digest::MD5.hexdigest(rand(100_000_000_000..999_999_999_999).to_s)
  end
end
