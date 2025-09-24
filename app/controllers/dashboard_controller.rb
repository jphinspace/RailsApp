class DashboardController < ApplicationController
  def index
    @total_revenue = Sale.total_revenue
    @total_page_views = UserAnalytic.total_page_views
    @unique_users = UserAnalytic.unique_users
    @average_session_duration = UserAnalytic.average_session_duration
    
    @recent_sales = Sale.recent.limit(5)
    @revenue_by_category = Sale.revenue_by_category
    @categories = Sale.categories
  end

  def sales
    @sales = Sale.all
    @revenue_by_category = Sale.revenue_by_category
    @sales_by_date = Sale.sales_by_date
    @total_revenue = Sale.total_revenue
    @categories = Sale.categories
    
    # Data for charts
    @category_chart_data = @revenue_by_category.map { |k, v| [k, v.to_f] }
    @date_chart_data = @sales_by_date.sort_by { |k, v| k }.map { |k, v| [k.strftime('%Y-%m-%d'), v.to_f] }
  end

  def analytics
    @user_analytics = UserAnalytic.all
    @total_page_views = UserAnalytic.total_page_views
    @unique_users = UserAnalytic.unique_users
    @average_session_duration = UserAnalytic.average_session_duration
    @page_views_by_date = UserAnalytic.page_views_by_date
    @session_duration_by_date = UserAnalytic.session_duration_by_date
    
    # Data for charts
    @page_views_chart_data = @page_views_by_date.sort_by { |k, v| k }.map { |k, v| [k.strftime('%Y-%m-%d'), v] }
    @session_duration_chart_data = @session_duration_by_date.sort_by { |k, v| k }.map { |k, v| [k.strftime('%Y-%m-%d'), v.to_f.round(2)] }
  end
end
