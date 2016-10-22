require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :poltergeist
