# Set up SimpleCov for code coverage before loading any application code
require "simplecov"
SimpleCov.start "rails" do
  enable_coverage :branch
  enable_coverage :line

  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/spec/" # if using RSpec
  add_filter "/test/"
  add_filter "/config/"
  add_filter "/vendor/"

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Views", "app/views"
  add_group "Helpers", "app/helpers"
  add_group "Jobs", "app/jobs"
  add_group "Mailers", "app/mailers"

  # Set different minimum coverage for system tests vs unit tests
  # System tests only exercise UI paths and have lower coverage expectations  
  # Unit tests exercise most code paths and maintain higher coverage requirements
  # The 99% requirement is enforced by our comprehensive coverage rake task
  
  # Check if system tests are running via environment variable
  if ENV["RAILS_SYSTEM_TESTING"] == "true"
    minimum_coverage 40  # Lower threshold for system tests
  else
    minimum_coverage 80  # Standard threshold for unit tests  
  end

  # Handle parallel test execution
  command_name "MiniTest#{ENV['TEST_ENV_NUMBER']}"
  merge_timeout 3600
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    # Reduced workers for better coverage tracking
    parallelize(workers: 1)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
