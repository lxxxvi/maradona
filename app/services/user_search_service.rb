class UserSearchService
  attr_reader :search_terms, :squad

  def initialize(search_terms, squad_parameterized_name)
    @search_terms = search_terms
    @squad = Squad.find_by(parameterized_name: squad_parameterized_name)
  end

  def find_player_ids
    return if @squad.blank?
    query = active_users_not_in_squad

    search_terms.split(' ').map do |search_term|
      query = query.where("
          lower(player_id) LIKE :term
       OR lower(nickname)  LIKE :term", term: "%#{search_term.downcase}%")
    end

    player_ids_with_nicknames(query)
  end

  private

  def active_users_not_in_squad
    user_ids_in_squad = SquadMember.where(squad: squad).pluck(:user_id)
    User.active.where.not(id: user_ids_in_squad)
  end

  def player_ids_with_nicknames(query)
    query
      .ordered
      .select(:player_id, :nickname).map do |user|
        user.attributes.slice("player_id", "nickname")
    end
  end
end
