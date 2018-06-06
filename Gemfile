source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#rubocop for automatic code styling
gem 'rubocop', '~> 0.57.0'

#react-rails gem for rendering components in react
gem 'react-rails', '~> 2.4', '>= 2.4.4'
gem 'babel-source', '~> 5.8', '>= 5.8.35'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Bootstrap 4.0 for responsive web app
gem 'bootstrap', '~> 4.1.1'

#Autoprefixer to parse css and add prefixes to css rules
gem 'autoprefixer-rails', '~> 8.5'

#Webpacker for react
gem 'webpacker', '~> 3.5', '>= 3.5.3'

#Devise gem for authentication
gem 'devise', '~> 4.4.3'

#Cancancan gem for authorization
gem 'cancancan', '~> 2.2.0'

#Doorkeeper gem for oAuth
gem 'doorkeeper', '~> 4.3.2'

#Factory bot for using and defining factories
gem 'factory_bot', '~> 4.8', '>= 4.8.2'

#Active support and its dependencies
gem 'activesupport', '~> 5.2'
gem 'concurrent-ruby', '~> 1.0', '>= 1.0.5'
gem 'i18n', '~> 1.0', '>= 1.0.1'
gem 'tzinfo', '~> 1.2', '>= 1.2.5'
gem 'thread_safe', '~> 0.3.6'
gem 'atomic', '~> 1.1', '>= 1.1.101'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
