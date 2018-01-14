class CreateGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.column :name, :string, null: false
    end

    add_index :groups, [:name], unique: true
  end
end
