class UpdateSquadMembersRankingsService
  attr_reader :squad

  def initialize(squad = nil)
    @squad = squad
  end

  def run!
    ActiveRecord::Base.connection.execute(udpate_squad_members_rankings_sql)
  end

  # private

  def udpate_squad_members_rankings_sql
    <<-SQL
      WITH ranked_squads_users AS (
        SELECT sup.user_id              AS user_id
             , sup.squad_id             AS squad_id
             , sup.user_points_total    AS user_points_total
             , rank() OVER (
                  PARTITION BY squad_id
                      ORDER BY user_points_total DESC
               )                        AS ranking_position
          FROM (
            SELECT sm.user_id                   AS user_id
                 , sm.squad_id                  AS squad_id
                 , COALESCE(u.points_total, 0)  AS user_points_total
              FROM squad_members sm
             INNER JOIN users u     ON u.id = sm.user_id
             WHERE sm.invitation_accepted_at IS NOT NULL
               AND #{squad_filter_sql}
           ) sup /* squad user points */
      )
      UPDATE squad_members sm2
         SET ranking_position = ranked_squads_users.ranking_position
        FROM ranked_squads_users
       WHERE sm2.user_id = ranked_squads_users.user_id
         AND sm2.squad_id = ranked_squads_users.squad_id
    SQL
  end

  def squad_filter_sql
    return '0 = 0' unless squad.present?

    "sm.squad_id = #{squad.id}"
  end
end
