source 'https://rubygems.org'
ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'devise_token_auth'
gem 'omniauth'
gem 'rack-cors', :require => 'rack/cors'
gem 'whenever', require: false
gem 'rolify'
gem 'active_model_serializers'
gem 'carrierwave-base64'
gem 'carrierwave'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'progress_bar'
gem 'sendgrid-actionmailer'
gem 'settingslogic'
gem 'haml-rails'
gem 'cancancan', '~> 2.0'
gem 'redis-rails'
gem 'kaminari'
gem 'api-pagination'
gem 'file_validators'
gem 'bigbluebutton_rails', git: 'https://gitlab.com/hieupt/bbb-gem.git'
gem 'pundit'
gem 'sidekiq'
gem 'asset_sync'
gem 'fog-aws'

group :development, :test do
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
