if Rails.env.development?
  Rake::Task['db:fixtures:load'].invoke
end
