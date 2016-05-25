ruby '2.2.1'

source 'https://rubygems.org'

gem 'rails', '~> 4.2.5'
gem 'sinatra', :require => nil
gem 'puma'
gem 'sidekiq'
gem 'composite_primary_keys', '~> 8.0'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-4-x'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-vkontakte'
gem 'omniauth-google-oauth2'
gem 'devise'
gem 'cancan'
gem 'fog'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', branch: '0.11-stable'
gem 'carrierwave_backgrounder'
gem 'active_model_serializers', '0.10.0.rc4'
gem 'redcarpet'
gem 'mini_magick'

# Interpreters
gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'coffee-rails', '~> 4.1.0'
gem 'less-rails'
gem 'uglifier', '~> 3'
gem 'sass-rails'

# Assests
gem 'i18n-js', '>= 3.0.0.rc11'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'handlebars_assets'
gem 'hamlbars'
gem 'rails-backbone'
gem 'bootstrap-datepicker-rails'
gem 'lightbox2-rails', '~> 2.7.0'

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'yui-compressor'
end

group :development, :test do
  gem 'sqlite3'
  gem 'spring'
  #gem 'capistrano-rails'
end

group :development do
  gem 'better_errors'
  gem 'byebug'
  gem 'binding_of_caller'
end

group :test do
  gem 'timecop'
  gem 'rspec-rails'
  gem 'fakeredis'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
end