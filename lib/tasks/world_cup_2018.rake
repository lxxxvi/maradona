namespace :world_cup_2018 do
  desc 'Move kickoff times relatively to current time'
  task move_kickoff_times: :environment do |t, args|
    raise 'Not allowed to run in production' if Rails.env.production?

    match_number = args.to_a.first.to_i
    unless (1..matches_count).include?(match_number)
      show_help_for_move_kickoff_times
      raise "Given match number '#{match_number}' is not allowed" 
    end

    nth_match = Match.order(:kickoff_at).limit(1).offset(match_number-1).first
    delta = (nth_match.kickoff_at - Time.zone.now).to_i

    Match.find_each do |match|
      new_match_kickoff_time = (match.kickoff_at - delta.seconds)
      match.update(kickoff_at: new_match_kickoff_time)
    end
  end

  private

  def matches_count
    @matches_count ||= Match.count
  end

  def show_help_for_move_kickoff_times
    puts <<-HELP
  Usage:

    bundle exec rake world_cup_2018:move_kickoff_times[n]

    # zsh
    bundle exec rake world_cup_2018:move_kickoff_times\\[n\\]        

    Arguments
    n     : Move "now" to kickoff of n-th match (must be between 1 and #{matches_count})
    HELP
  end
end
