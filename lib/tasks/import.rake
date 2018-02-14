namespace :import do
  desc 'World Cup 2018 in Russia'
  task world_cup_2018: :environment do
    world_cup_2018_data_directory_path = Rails.root.join("db/data/world_cup_2018/")
    sql_file_names = [
      '01_venues.sql',
      '02_teams.sql',
      '03_matches.sql'
    ]

    sql_file_names.each do |sql_file_name|
      sql_file_path = world_cup_2018_data_directory_path.join(sql_file_name)
      puts "loading #{sql_file_path}"
      ActiveRecord::Base.connection.execute(sql_file_path.read)
    end
  end

  desc 'Names'
  task names: :environment do
    names_data_directory_path = Rails.root.join('db/data/names/')

    names_file_names = [
      'first_names.sql',
      'last_names.sql'
    ]

    names_file_names.each do |names_file_name|
      sql_file_path = names_data_directory_path.join(names_file_name)
      puts "loading #{sql_file_path}"
      ActiveRecord::Base.connection.execute(sql_file_path.read)
    end
  end
end
