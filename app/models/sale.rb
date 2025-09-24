class Sale < ApplicationRecord
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :product_name, presence: true
  validates :category, presence: true
  validates :sale_date, presence: true

  scope :by_category, ->(category) { where(category: category) }
  scope :by_date_range, ->(start_date, end_date) { where(sale_date: start_date..end_date) }
  scope :recent, -> { where(sale_date: 30.days.ago..Date.current) }

  def self.total_revenue
    sum(:amount)
  end

  def self.revenue_by_category
    group(:category).sum(:amount)
  end

  def self.sales_by_date
    group(:sale_date).sum(:amount)
  end

  def self.categories
    distinct.pluck(:category).compact
  end
end
