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
  add_filter "/test/system" # Exempt system test from coverage

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Views", "app/views"
  add_group "Helpers", "app/helpers"
  add_group "Jobs", "app/jobs"
  add_group "Mailers", "app/mailers"

  # Set minimum coverage only for non-system tests
  # System tests don't exercise all code paths, so we skip minimum coverage for them
  is_system_test = caller.any? { |line| line.include?("/test/system/") } ||
                   ENV["RAILS_TEST_FILES"]&.include?("system") ||
                   $PROGRAM_NAME.include?("system")

  unless is_system_test
    minimum_coverage 80
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
