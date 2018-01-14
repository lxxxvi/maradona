class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.column :email,    :string, null: false
      t.column :nickname, :string, null: false

      t.timestamps
    end

    add_index :users, [:email],     unique: true
    add_index :users, [:nickname],  unique: true
  end
end
