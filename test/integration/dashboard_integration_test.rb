require "test_helper"

class DashboardIntegrationTest < ActionDispatch::IntegrationTest
  test "visiting the dashboard" do
    get root_url
    
    assert_response :success
    assert_select "h1", text: "📊 Dashboard Overview"
    assert_select ".card", count: 4
    assert_select ".chart-container"
    
    # Check navigation
    assert_select "nav.navbar"
    assert_select "a[href=?]", dashboard_sales_path, text: "Sales"
    assert_select "a[href=?]", dashboard_analytics_path, text: "Analytics"
  end

  test "navigating to sales dashboard" do
    get dashboard_sales_path
    
    assert_response :success
    assert_select "h1", text: "💰 Sales Dashboard"
    assert_select ".stat-card", count: 4
    
    # Check navigation links
    assert_select "nav.navbar"
    assert_select "a[href=?]", root_path, text: "Overview"
    assert_select "a[href=?]", dashboard_analytics_path, text: "Analytics"
  end

  test "navigating to analytics dashboard" do
    get dashboard_analytics_path
    
    assert_response :success
    assert_select "h1", text: "📈 User Analytics"
    assert_select ".stat-card", count: 4
    
    # Check navigation links
    assert_select "nav.navbar"
    assert_select "a[href=?]", root_path, text: "Overview"
    assert_select "a[href=?]", dashboard_sales_path, text: "Sales"
  end

  test "sales dashboard displays data" do
    get dashboard_sales_path
    
    assert_response :success
    # Check that we have data tables
    assert_select "table.data-table"
    assert_select "th", text: "Product Name"
    assert_select "th", text: "Category"
    assert_select "th", text: "Amount"
    assert_select "th", text: "Sale Date"
    
    # Check for actual data rows (from fixtures)
    assert_select "td", text: "MacBook Pro"
    assert_select "td", text: "Electronics"
  end

  test "analytics dashboard displays data" do
    get dashboard_analytics_path
    
    assert_response :success
    # Check that we have data tables
    assert_select "table.data-table"
    assert_select "th", text: "User ID"
    assert_select "th", text: "Page Views"
    assert_select "th", text: "Session Duration"
    assert_select "th", text: "Date"
    
    # Check for actual data rows (from fixtures)
    assert_select "td", text: /User #\d+/
  end

  test "charts are displayed correctly on all pages" do
    # Overview page
    get root_url
    assert_response :success
    assert_select ".chart-container"
    assert_select ".bar-chart"
    assert_select ".chart-title", text: "Revenue by Category"
    
    # Sales page
    get dashboard_sales_path
    assert_response :success
    assert_select ".chart-container", count: 3
    
    # Analytics page
    get dashboard_analytics_path
    assert_response :success
    assert_select ".chart-container", count: 3
  end

  test "responsive design elements are present" do
    get root_url
    
    assert_response :success
    # Navigation should be present
    assert_select "nav.navbar"
    
    # Cards should be present
    assert_select ".card", count: 4
    
    # Essential responsive elements should be in HTML
    assert_select "meta[name='viewport']"
  end
end