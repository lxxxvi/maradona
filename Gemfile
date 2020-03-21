ruby '2.6.5'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootsnap'
gem 'bootstrap'
gem 'bugsnag'
gem 'devise'
gem 'haml-rails'
gem 'inline_svg'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'rails', '~> 5.2'
gem 'sass-rails'
gem 'uglifier'

group :production do
  gem 'redis'
end

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'simplecov', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console'
end
