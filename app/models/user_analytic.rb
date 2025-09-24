class UserAnalytic < ApplicationRecord
  validates :user_id, presence: true
  validates :page_views, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :session_duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }
  scope :recent, -> { where(date: 30.days.ago..Date.current) }

  def self.total_page_views
    sum(:page_views)
  end

  def self.average_session_duration
    average(:session_duration)
  end

  def self.page_views_by_date
    group(:date).sum(:page_views)
  end

  def self.session_duration_by_date
    group(:date).average(:session_duration)
  end

  def self.unique_users
    distinct.count(:user_id)
  end
end
