# rubocop:disable Metrics/MethodLength
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.string   :reset_password_token, null: true
      t.datetime :reset_password_sent_at, null: true

      t.datetime :remember_created_at, null: true

      t.timestamps

      t.index [:username], unique: true
      t.index [:slug], unique: true
      t.index [:email], unique: true
      t.index [:reset_password_token], unique: true
    end
  end
end
# rubocop:enable Metrics/MethodLength
