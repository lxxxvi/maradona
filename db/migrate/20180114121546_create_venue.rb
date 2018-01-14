class CreateVenue < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.column :what3words, :string, null: false
      t.column :name,       :string, null: false
      t.column :city,       :string, null: false
      t.column :timezone,   :string, null: false
    end

    add_index :venues, [:what3words], unique: true
    add_index :venues, [:name],       unique: true
  end
end
