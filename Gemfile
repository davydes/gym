ruby '2.2.1'

source 'https://rubygems.org'

gem 'rails', '~> 4.2.5'
gem 'composite_primary_keys', '~> 8.0'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-4-x'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-vkontakte'
gem 'devise'
gem 'cancan'
gem 'fog'
gem 'carrierwave'
gem 'active_model_serializers', '0.10.0.rc4'
gem 'redcarpet'
gem 'mini_magick'
#gem 'sdoc', '~> 0.4.0', group: :doc
#gem 'bcrypt', '~> 3.1.7'

# Interpreters
gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'coffee-rails', '~> 4.1.0'
gem 'less-rails'
gem 'uglifier', '~> 2.7'

# Assests
gem "i18n-js", ">= 3.0.0.rc11"
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'handlebars_assets'
gem 'hamlbars'
gem 'rails-backbone'
gem 'bootstrap-datepicker-rails'
gem 'lightbox2-rails'

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'unicorn'
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
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
end