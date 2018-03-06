class CreateSquad < ActiveRecord::Migration[5.1]
  def change
    create_table :squads do |t|
      t.column :name              , :string , null: false
      t.column :parameterized_name, :string , null: false
      t.column :points_total      , :integer, null: false, default: 0
      t.column :ranking_position  , :integer, null: true

      t.timestamps
    end

    add_index :squads, [:name]              , unique: true, name: 'uk_squads_name'
    add_index :squads, [:parameterized_name], unique: true, name: 'uk_squads_parameterized_name'
  end
end
