class CreateNames < ActiveRecord::Migration[5.1]
  def change
    create_table :names, id: false do |t|
      t.integer :part, null: false
      t.string :value, null: false
    end

    add_index :names, [:part, :value], name: 'uk_names_part_name', unique: true
  end
end
