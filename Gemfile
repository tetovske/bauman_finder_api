source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'sass-rails', '~> 5'
gem 'uglifier'
gem 'coffee-rails'
gem 'sprockets', '~> 3'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'webpacker', '~> 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'bcrypt-ruby', '~> 3.1.2'

# Sidekiq for async stuff
gem 'sidekiq'
# Schedule tasks
gem 'sidekiq-cron'
# Special for sidekiq
gem 'sinatra', github: 'sinatra/sinatra'

# Create schedules
gem 'whenever', :require => false

# For business logic
gem 'interactor'

# For pdf parsing
gem 'pdf-reader'

# For registration
gem 'jwt'

gem 'pg'

# Dry style 
gem 'dry-monads'
gem 'dry-transaction'
gem 'dry-container'
gem 'dry-auto_inject'

# slim
gem 'slim-rails'
gem 'haml'

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

# For web parsing
gem 'selenium-webdriver'
gem 'mechanize'
gem 'nokogiri'

# Internationalization
gem 'rails-i18n', '~> 6.0.0'

# CSS lib
gem 'bulma-rails', '~> 0.8.0'
gem 'particles-js-rails'
gem 'rails-ujs'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'factory_bot'
  gem 'database_cleaner'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'pry-rails'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
