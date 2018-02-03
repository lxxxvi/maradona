class DropGroup < ActiveRecord::Migration[5.1]
  def up
    drop_table :groups
  end
end
