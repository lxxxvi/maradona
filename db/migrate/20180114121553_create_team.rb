class CreateTeam < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.references :group, foreign_key: true
      t.column :fifa_country_code,  :string,  null: false
      t.column :name,               :string,  null: false
      t.column :group_order,        :integer, null: false
    end

    add_index :teams, [:fifa_country_code], unique: true
    add_index :teams, [:name],              unique: true
  end
end
