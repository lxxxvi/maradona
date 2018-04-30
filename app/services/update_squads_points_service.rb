class UpdateSquadsPointsService
  def run!
    ActiveRecord::Base.connection.execute(update_squads_points_sql)
  end

  private

  def update_squads_points_sql
    <<-SQL
      WITH squad_points AS (
        SELECT sm.squad_id                    AS squad_id
             , sum(u.points_total)            AS total
             , round(avg(u.points_total))     AS average /* ignores NULL values ! */
          FROM squad_members sm
         INNER JOIN users        u  ON u.id   = sm.user_id
         WHERE sm.invitation_accepted_at IS NOT NULL
         GROUP BY sm.squad_id
      )
      UPDATE squads
         SET points_total   = COALESCE(squad_points.total, 0)
           , points_average = COALESCE(squad_points.average, 0)
        FROM squad_points
       WHERE squad_points.squad_id = squads.id
    SQL
  end
end
