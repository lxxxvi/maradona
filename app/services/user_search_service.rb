class UserSearchService
  attr_reader :player_id_likes, :squad

  def initialize(player_id_likes, squad_parameterized_name)
    @player_id_likes = player_id_likes
    @squad = Squad.find_by(parameterized_name: squad_parameterized_name)
  end

  def find_player_ids
    return if @squad.blank?
    query = active_users_not_in_squad

    player_id_likes.split(' ').map do |player_id_like|
      query = query.where("player_id LIKE ?", "%#{player_id_like.downcase}%")
    end

    query.ordered.pluck(:player_id)
  end

  def active_users_not_in_squad
    user_ids_in_squad = SquadMember.where(squad: squad).pluck(:user_id)
    User.active.where.not(id: user_ids_in_squad)
  end
end
