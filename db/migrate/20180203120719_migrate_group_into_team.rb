class MigrateGroupIntoTeam < ActiveRecord::Migration[5.1]
  def change
    Team.all.each do |team|
      group = Group.find(team.group_id)
      team.update(group_letter: group.name)
    end
  end
end
