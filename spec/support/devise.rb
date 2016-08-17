require 'devise'
# Disable backgrounder proxy for tests
Devise.mailer = Devise::Mailer

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
end
