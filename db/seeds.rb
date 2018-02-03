if Rails.env.development?
  Rake::Task['db:fixtures:load'].invoke
end

# Admin User
User.find_or_initialize_by(nickname: 'diego.maradona').tap do |diego|
  diego.email = 'diego.maradona@tippkick.club'
  diego.save!
end
