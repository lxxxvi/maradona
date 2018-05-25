class MigrateNicknameOnUser < ActiveRecord::Migration[5.2]
  def up
    run(migrate_nickname_sql)
  end

  def down
    run(reset_nickname_sql)
  end

  private

  def run(statement)
    ActiveRecord::Base.connection.execute(statement)
  end

  def migrate_nickname_sql
    <<-SQL
      UPDATE users
         SET nickname = player_id
       WHERE nickname IS NULL
    SQL
  end

  def reset_nickname_sql
    <<-SQL
      UPDATE users
         SET nickname = NULL
    SQL
  end
end
