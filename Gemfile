ruby '2.6.3'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12'
gem 'haml-rails'
gem 'bootstrap', '>= 4.3.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'inline_svg'
gem 'devise'
gem 'jquery-rails'
gem 'pundit'
gem 'bugsnag', '~> 6.6'
gem 'bootsnap'

# gem 'therubyracer', platforms: :ruby
# gem 'jbuilder', '~> 2.5'
# gem 'bcrypt', '~> 3.1.7'

group :production do
  gem 'redis', '~> 3.0'
end

group :development, :test do
  gem 'byebug'
  # gem 'capybara', '~> 2.13'
  # gem 'selenium-webdriver'
end

group :test do
  gem 'simplecov', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end
