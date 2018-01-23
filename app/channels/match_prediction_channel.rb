class MatchPredictionChannel < ApplicationCable::Channel
  def subscribed
    stream_for User.first
  end

  def receive(data)
    match             = Match.find(data['matchId'])
    user              = User.first
    left_team_score   = data['leftTeamScore']
    right_team_score  = data['rightTeamScore']

    service = MatchPredictionUpdaterService.new(match, user)
    response = service.update(left_team_score, right_team_score)

    MatchPredictionChannel.broadcast_to(User.first, matchPredictionUpdaterResponse: response)
  end
end
