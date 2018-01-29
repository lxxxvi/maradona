namespace :development do
  desc 'Modify some games'
  task modify_games: :environment do
    pass_in_development
    team_rus = Team.find_by(fifa_country_code: 'RUS')
    team_ksa = Team.find_by(fifa_country_code: 'KSA')
    match_rus_ksa = Match.find_by(phase: 'Group stage', left_team: team_rus, right_team: team_ksa)
    match_rus_ksa.update(kickoff_at: Time.zone.now)
  end

  def pass_in_development
    raise "Can only run in development" unless Rails.env.development?
  end
end
