require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h1", text: /Dashboard Overview/
    assert_select ".card", count: 4
    assert_select ".chart-container", minimum: 1
  end

  test "should get dashboard index with data" do
    get dashboard_index_url
    assert_response :success

    # Check that instance variables are set
    assert assigns(:total_revenue)
    assert assigns(:total_page_views)
    assert assigns(:unique_users)
    assert assigns(:average_session_duration)
    assert assigns(:recent_sales)
    assert assigns(:revenue_by_category)
    assert assigns(:categories)
  end

  test "should get sales" do
    get dashboard_sales_url
    assert_response :success
    assert_select "h1", text: /Sales Dashboard/
    assert_select ".stat-card", count: 4
    assert_select ".chart-container", minimum: 2
    assert_select "table.data-table"
  end

  test "should get sales with data" do
    get dashboard_sales_url

    # Check that instance variables are set
    assert assigns(:sales)
    assert assigns(:revenue_by_category)
    assert assigns(:sales_by_date)
    assert assigns(:total_revenue)
    assert assigns(:categories)
    assert assigns(:category_chart_data)
    assert assigns(:date_chart_data)
  end

  test "should get analytics" do
    get dashboard_analytics_url
    assert_response :success
    assert_select "h1", text: /User Analytics/
    assert_select ".stat-card", count: 4
    assert_select ".chart-container", minimum: 2
    assert_select "table.data-table"
  end

  test "should get analytics with data" do
    get dashboard_analytics_url

    # Check that instance variables are set
    assert assigns(:user_analytics)
    assert assigns(:total_page_views)
    assert assigns(:unique_users)
    assert assigns(:average_session_duration)
    assert assigns(:page_views_by_date)
    assert assigns(:session_duration_by_date)
    assert assigns(:page_views_chart_data)
    assert assigns(:session_duration_chart_data)
  end

  test "sales page should display sales data" do
    get dashboard_sales_url

    # Check for sales data in the response
    assert_select "td", text: sales(:laptop).product_name
    assert_select "td", text: sales(:shirt).category
  end

  test "analytics page should display user analytics" do
    get dashboard_analytics_url

    # Check for analytics data in the response
    assert_select "td", text: /User ##{user_analytics(:user_one_today).user_id}/
  end

  test "navigation links should be present" do
    get root_url

    assert_select "nav.navbar"
    assert_select "a[href='#{root_path}']", text: /Dashboard/
    assert_select "a[href='#{dashboard_sales_path}']", text: "Sales"
    assert_select "a[href='#{dashboard_analytics_path}']", text: "Analytics"
  end

  test "should handle empty data gracefully" do
    # Clear all data
    Sale.destroy_all
    UserAnalytic.destroy_all

    get root_url
    assert_response :success

    get dashboard_sales_url
    assert_response :success

    get dashboard_analytics_url
    assert_response :success
  end
end
