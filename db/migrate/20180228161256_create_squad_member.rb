class CreateSquadMember < ActiveRecord::Migration[5.1]
  def change
    create_table :squad_members do |t|
      t.column :squad_id              , :integer  , null: false
      t.column :user_id               , :integer  , null: false
      t.column :coach                 , :boolean  , null: false, default: false
      t.column :invitation_sent_at    , :datetime , null: false
      t.column :invitation_accepted_at, :datetime , null: true
      t.column :ranking_position      , :integer  , null: true

      t.timestamps
    end

    add_index :squad_members, [:squad_id, :user_id], unique: true
  end
end
