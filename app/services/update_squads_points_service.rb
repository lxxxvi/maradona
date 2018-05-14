class UpdateSquadsPointsService
  attr_reader :squad

  def initialize(squad = nil)
    @squad = squad
  end

  def run!
    ActiveRecord::Base.connection.execute(update_squads_points_sql)
  end

  private

  def update_squads_points_sql
    <<-SQL
      WITH squad_stats AS (
        SELECT sm.squad_id                          AS squad_id
             , sum(u.points_total)                  AS total
             , round(avg(u.points_total) * 100)     AS average /* ignores NULL values ! */
             , count(*)                             AS players_count
          FROM squad_members sm
         INNER JOIN users        u  ON u.id   = sm.user_id
         WHERE sm.invitation_accepted_at IS NOT NULL
           AND sm.deactivated_at IS NULL
           AND #{squad_filter_sql}
         GROUP BY sm.squad_id
      )
      UPDATE squads
         SET points_total           = COALESCE(squad_stats.total, 0)
           , points_average         = COALESCE(squad_stats.average, 0)
           , accepted_players_total = squad_stats.players_count
        FROM squad_stats
       WHERE squad_stats.squad_id = squads.id
    SQL
  end

  def squad_filter_sql
    return '0 = 0' unless squad.present?

    "sm.squad_id = #{squad.id}"
  end
end
