class MatchPredictionChannel < ApplicationCable::Channel
  def subscribed
    stream_for User.first
  end

  def receive(data)
    puts data

    MatchPredictionChannel.broadcast_to(User.first, "Im your echo")
  end
end
