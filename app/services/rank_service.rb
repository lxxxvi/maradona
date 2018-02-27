class RankService
  def run!
    ActiveRecord::Base.connection.execute(rank_users_sql)
  end

  private
    def rank_users_sql
      <<-EOF
        WITH ranked_users AS (
            SELECT id                                                    AS id
                 , rank() OVER (ORDER BY COALESCE(points_total, 0) DESC) AS ranking_position
              FROM users
        )
        UPDATE users
           SET ranking_position = ranked_users.ranking_position
          FROM ranked_users
         WHERE users.id = ranked_users.id
      EOF
    end
end
