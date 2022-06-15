source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'puma', '~> 5.0'

gem 'pg'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'uglifier'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-vkontakte'
gem 'omniauth-google-oauth2'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

gem 'carrierwave', '~> 2.0'
gem 'rmagick'
gem 'fog-aws'
gem 'mailjet'
gem 'resque'
gem 'pundit'
gem 'where_exists'

group :development, :test do
  gem 'rspec-rails'
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'capistrano',           require: false
  gem 'capistrano-rbenv',     require: false
  gem 'capistrano-rails',     require: false
  gem 'capistrano-bundler',   require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-resque',    require: false

  gem 'letter_opener'
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
end
