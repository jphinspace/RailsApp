require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  test "visiting the dashboard" do
    visit root_url

    assert_selector "h1", text: "Dashboard Overview"
    assert_selector ".card", count: 4
    assert_selector ".chart-container"

    # Check navigation
    assert_selector "nav.navbar"
    assert_link "Sales"
    assert_link "Analytics"
  end

  test "navigating between dashboard pages" do
    visit root_url

    # Test navigation to Sales page
    click_link "Sales"
    assert_current_path dashboard_sales_path
    assert_selector "h1", text: "Sales Dashboard"
    assert_selector ".stat-card", count: 4

    # Test navigation to Analytics page
    click_link "Analytics"
    assert_current_path dashboard_analytics_path
    assert_selector "h1", text: "User Analytics"
    assert_selector ".stat-card", count: 4

    # Test navigation back to Overview
    click_link "Overview"
    assert_current_path root_path
    assert_selector "h1", text: "Dashboard Overview"
  end

  test "sales dashboard displays data" do
    visit dashboard_sales_path

    # Check that we have data tables
    assert_selector "table.data-table"
    assert_selector "th", text: "Product Name"
    assert_selector "th", text: "Category"
    assert_selector "th", text: "Amount"
    assert_selector "th", text: "Sale Date"

    # Check for actual data rows (from fixtures)
    assert_selector "td", text: "MacBook Pro"
    assert_selector "td", text: "Electronics"
  end

  test "analytics dashboard displays data" do
    visit dashboard_analytics_path

    # Check that we have data tables
    assert_selector "table.data-table"
    assert_selector "th", text: "User ID"
    assert_selector "th", text: "Page Views"
    assert_selector "th", text: "Session Duration"
    assert_selector "th", text: "Date"

    # Check for actual data rows (from fixtures)
    assert_selector "td", text: /User #\d+/
  end

  test "responsive design works on mobile" do
    # Test mobile viewport
    page.driver.browser.manage.window.resize_to(375, 667)

    visit root_url

    # Navigation should still be visible and functional
    assert_selector "nav.navbar"
    assert_link "Sales"
    assert_link "Analytics"

    # Cards should still be visible
    assert_selector ".card", count: 4
  end

  test "charts are displayed correctly" do
    visit root_url

    # Check for chart containers
    assert_selector ".chart-container"
    assert_selector ".bar-chart"

    # Check chart titles
    assert_selector ".chart-title", text: "Revenue by Category"

    # Visit sales page for more charts
    visit dashboard_sales_path
    assert_selector ".chart-container", count: 3

    # Visit analytics page for analytics charts
    visit dashboard_analytics_path
    assert_selector ".chart-container", count: 3
  end
end
