class MatchPredictionChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def receive(data)
    match             = Match.find(data['matchId'])
    user              = current_user
    left_team_score   = data['leftTeamScore']
    right_team_score  = data['rightTeamScore']

    service = MatchPredictionUpdaterService.new(match, user)
    response = service.update(left_team_score, right_team_score)

    MatchPredictionChannel.broadcast_to(current_user, matchPredictionUpdaterResponse: response)
  end
end
