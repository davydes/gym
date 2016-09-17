ruby '2.1.10'

source 'https://rubygems.org'

gem 'rails', '~> 4.2.5'
gem 'sinatra', :require => nil
gem 'sidekiq'
gem 'sidekiq-cron', '~> 0.4.0'
gem 'composite_primary_keys', '~> 8.0'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-4-x'
gem 'omniauth'
#gem 'omniauth-twitter'
#gem 'omniauth-facebook'
#gem 'omniauth-linkedin'
gem 'omniauth-vkontakte'
gem 'omniauth-google-oauth2'
gem 'devise'
gem 'cancancan'
gem 'fog'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', branch: '0.11-stable'
gem 'carrierwave_backgrounder'
gem 'active_model_serializers', '~> 0.10'
gem 'mini_magick'
gem 'figaro'

# Interpreters
gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'coffee-rails', '~> 4.1.0'
gem 'less-rails'
gem 'uglifier', '~> 3'
gem 'sass-rails'
gem 'redcarpet' # Markdown

# Assests
gem 'i18n-js', '>= 3.0.0.rc11'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'handlebars_assets'
gem 'hamlbars'
gem 'rails-backbone'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'lightbox2-rails', '~> 2.7.0'

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
  gem 'yui-compressor'
  gem 'unicorn-rails'
end

group :development, :test do
  gem 'spring'
  gem 'sqlite3'
  gem 'pry-rails'
end

group :development do
  gem 'letter_opener'
  gem 'better_errors'
  gem 'byebug'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'puma'
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm'
  gem 'capistrano-faster-assets', '~> 1.0'
end

group :test do
  gem 'timecop'
  gem 'rspec-rails'
  gem 'fakeredis'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
  gem 'capybara'
  gem 'selenium-webdriver'
end
