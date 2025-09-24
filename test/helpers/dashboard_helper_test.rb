require "test_helper"

class DashboardHelperTest < ActionView::TestCase
  include DashboardHelper

  test "helper module is loaded" do
    # Test that the helper module is included
    assert_includes self.class.included_modules, DashboardHelper
  end
  
  test "application helper methods are available" do
    # Test basic Rails helper availability
    assert_respond_to self, :number_with_delimiter
    assert_respond_to self, :link_to
  end

  test "format_currency formats amounts properly" do
    assert_equal "$99.99", format_currency(99.99)
    assert_equal "$1,234.56", format_currency(1234.56)
    assert_equal "$0.00", format_currency(0)
  end

  test "format_percentage calculates percentages" do
    assert_equal "50.0%", format_percentage(50, 100)
    assert_equal "33.3%", format_percentage(100, 300)
    assert_equal "0.0%", format_percentage(0, 100)
    assert_equal "0%", format_percentage(50, 0)
  end

  test "format_duration formats time correctly" do
    assert_equal "30s", format_duration(30)
    assert_equal "2.5m", format_duration(150)  # 150/60 = 2.5
    assert_equal "1.5h", format_duration(5400)
    assert_equal "0s", format_duration(0)
    assert_equal "0s", format_duration(nil)
  end

  test "trend_indicator shows trend direction" do
    assert_equal "↗ +50.0%", trend_indicator(150, 100)
    assert_equal "↘ -25.0%", trend_indicator(75, 100)
    assert_equal "→ 0%", trend_indicator(100, 100)
    assert_equal "→", trend_indicator(100, 0)
    assert_equal "→", trend_indicator(100, nil)
  end

  test "chart_bar_height calculates heights correctly" do
    assert_equal 125, chart_bar_height(50, 100, 250)
    assert_equal 250, chart_bar_height(100, 100, 250)
    assert_equal 0, chart_bar_height(50, 0, 250)
    assert_equal 0, chart_bar_height(0, 100, 250)
  end
end