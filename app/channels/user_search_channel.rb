class UserSearchChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def receive(data)
    player_id_like = data['searchTerm']
    squad_parameterized_name = data['squadParameterizedName']
    found_player_ids = UserSearchService.new(player_id_like, squad_parameterized_name).find_player_ids
    UserSearchChannel.broadcast_to(current_user, playerIds: found_player_ids)
  end
end
