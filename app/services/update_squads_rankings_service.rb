class UpdateSquadsRankingsService
  def run!
    ActiveRecord::Base.connection.execute(rank_squads_sql)
  end

  private

  def rank_squads_sql
    <<-SQL
      WITH ranked_squads AS (
          SELECT id                                                    AS id
               , rank() OVER (ORDER BY COALESCE(points_average, -1) DESC) AS ranking_position
            FROM squads
      )
      UPDATE squads
         SET ranking_position = ranked_squads.ranking_position
        FROM ranked_squads
       WHERE squads.id = ranked_squads.id
    SQL
  end
end
