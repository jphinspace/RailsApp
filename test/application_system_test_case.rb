require "test_helper"

# Set environment variable to indicate system tests are running
ENV["RAILS_SYSTEM_TESTING"] = "true"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end
