class MatchPredictionChannel < ApplicationCable::Channel
  def subscribed
    puts "HOOOOOO!"
    stream_for User.first
  end

  def receive(data)
    puts "DID WE GET THIS??"
    puts data

    MatchPredictionChannel.broadcast_to(User.first, "Im your echo")
  end
end
