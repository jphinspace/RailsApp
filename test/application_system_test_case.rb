require "test_helper"

# Set environment variable to indicate system tests are running
ENV["RAILS_SYSTEM_TESTING"] = "true"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Use a more stable browser configuration for CI/headless environments
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |driver_opts|
    driver_opts.add_argument('--no-sandbox')
    driver_opts.add_argument('--disable-dev-shm-usage')
    driver_opts.add_argument('--disable-web-security')
    driver_opts.add_argument('--disable-features=VizDisplayCompositor')
  end
end
