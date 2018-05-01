class UpdateUsersPointsService
  def run!
    update_users_points_total_service
    update_users_points_match_average_service
  end

  private

  def update_users_points_total_service
    ActiveRecord::Base.connection.execute(update_users_points_total_service_sql)
  end

  def update_users_points_match_average_service
    ActiveRecord::Base.connection.execute(update_users_points_match_average_service_sql)
  end

  def update_users_points_total_service_sql
    <<-SQL
      WITH summed_users_points AS (
        SELECT user_id, sum(points_total) summed_points_total
          FROM predictions
      GROUP BY user_id
      )
      UPDATE users
         SET points_total = summed_users_points.summed_points_total
        FROM summed_users_points
       WHERE users.id = summed_users_points.user_id
    SQL
  end

  def update_users_points_match_average_service_sql
    <<-SQL
      UPDATE users
         SET points_match_average = ROUND(points_total / #{Match.finished.count.to_f} * 100)
    SQL
  end
end
