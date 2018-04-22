class UpdateUsersPointsService
  def run!
    ActiveRecord::Base.connection.execute(update_users_points_total_service_sql)
  end

  private
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
end
