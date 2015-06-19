require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gym
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Europe/Moscow'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.initialize_on_precompile = false

    # Override action_view proc
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }

    config.generators do |g|
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :fabrication, :dir => 'spec/factories'
      g.template_engine :haml
      g.stylesheet_engine :less
      g.javascript_engine :coffeescript
    end

    # Autoload lib
    config.autoload_paths << Rails.root.join('lib')

    # Mailer
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.delivery_method = :test
    config.action_mailer.perform_deliveries = false
  end
end
