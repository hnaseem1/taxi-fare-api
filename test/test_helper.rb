ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...


end

# class ActionDispatch::IntegrationTest
#   # Make the Capybara DSL available in all integration tests
#   include Capybara::DSL
#   # Make `assert_*` methods behave like Minitest assertions
#   include Capybara::Minitest::Assertions
#   Capybara.javascript_driver = :webkit

#   Capybara::Webkit.configure do |config|
#     config.allow_url("maps.googleapis.com")
#   end
#   # Reset sessions and driver between tests
#   # Use super wherever this method is redefined in your individual test classes
#   def teardown
#     Capybara.reset_sessions!
#     Capybara.use_default_driver
# end
# end