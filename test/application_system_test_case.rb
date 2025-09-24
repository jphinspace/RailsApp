require "test_helper"

# Adjust coverage threshold if this is a system-test-only run
# Check if any unit test classes have been loaded
at_exit do
  # If no unit test classes are loaded, this is likely a system-test-only run
  unit_test_classes = ObjectSpace.each_object(Class).select do |klass|
    klass < ActiveSupport::TestCase &&
    klass != ActiveSupport::TestCase &&
    klass != ApplicationSystemTestCase &&
    !klass.ancestors.include?(ApplicationSystemTestCase)
  end

  # If no unit test classes were loaded, lower the coverage threshold
  if unit_test_classes.empty? && defined?(SimpleCov)
    SimpleCov.minimum_coverage(line: 40)
  end
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Use a more stable browser configuration for CI/headless environments
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |driver_opts|
    driver_opts.add_argument("--no-sandbox")
    driver_opts.add_argument("--disable-dev-shm-usage")
    driver_opts.add_argument("--disable-web-security")
    driver_opts.add_argument("--disable-features=VizDisplayCompositor")
  end
end
