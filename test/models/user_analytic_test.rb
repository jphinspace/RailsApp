require "test_helper"

class UserAnalyticTest < ActiveSupport::TestCase
  def setup
    @user_analytic = UserAnalytic.new(
      user_id: 123,
      page_views: 10,
      session_duration: 1800,
      date: Date.current
    )
  end

  test "should be valid with valid attributes" do
    assert @user_analytic.valid?
  end

  test "should require user_id" do
    @user_analytic.user_id = nil
    assert_not @user_analytic.valid?
    assert_includes @user_analytic.errors[:user_id], "can't be blank"
  end

  test "should require page_views" do
    @user_analytic.page_views = nil
    assert_not @user_analytic.valid?
    assert_includes @user_analytic.errors[:page_views], "can't be blank"
  end

  test "should allow zero page_views" do
    @user_analytic.page_views = 0
    assert @user_analytic.valid?
  end

  test "should not allow negative page_views" do
    @user_analytic.page_views = -1
    assert_not @user_analytic.valid?
    assert_includes @user_analytic.errors[:page_views], "must be greater than or equal to 0"
  end

  test "should require session_duration" do
    @user_analytic.session_duration = nil
    assert_not @user_analytic.valid?
    assert_includes @user_analytic.errors[:session_duration], "can't be blank"
  end

  test "should allow zero session_duration" do
    @user_analytic.session_duration = 0
    assert @user_analytic.valid?
  end

  test "should not allow negative session_duration" do
    @user_analytic.session_duration = -1
    assert_not @user_analytic.valid?
    assert_includes @user_analytic.errors[:session_duration], "must be greater than or equal to 0"
  end

  test "should require date" do
    @user_analytic.date = nil
    assert_not @user_analytic.valid?
    assert_includes @user_analytic.errors[:date], "can't be blank"
  end

  test "total_page_views should sum all page views" do
    total = UserAnalytic.total_page_views
    expected = user_analytics(:user_one_today).page_views +
               user_analytics(:user_two_today).page_views +
               user_analytics(:user_one_yesterday).page_views +
               user_analytics(:user_three_yesterday).page_views
    assert_equal expected, total
  end

  test "average_session_duration should calculate average" do
    avg = UserAnalytic.average_session_duration
    assert avg > 0
    assert_kind_of Numeric, avg
  end

  test "unique_users should count distinct user_ids" do
    unique_count = UserAnalytic.unique_users
    assert_equal 3, unique_count  # users 1, 2, and 3 from fixtures
  end

  test "page_views_by_date should group by date" do
    views_by_date = UserAnalytic.page_views_by_date
    assert_includes views_by_date.keys, Date.current
    assert_includes views_by_date.keys, 1.day.ago.to_date
  end

  test "session_duration_by_date should group by date" do
    duration_by_date = UserAnalytic.session_duration_by_date
    assert_includes duration_by_date.keys, Date.current
    assert_includes duration_by_date.keys, 1.day.ago.to_date
  end

  test "recent scope should return analytics from last 30 days" do
    # Create analytics from 35 days ago
    old_analytic = UserAnalytic.create!(
      user_id: 999,
      page_views: 5,
      session_duration: 300,
      date: 35.days.ago.to_date
    )

    recent_analytics = UserAnalytic.recent
    assert_not_includes recent_analytics, old_analytic
    assert_includes recent_analytics, user_analytics(:user_one_today)
  end
end
