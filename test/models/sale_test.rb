require "test_helper"

class SaleTest < ActiveSupport::TestCase
  def setup
    @sale = Sale.new(
      amount: 99.99,
      product_name: "Test Product",
      category: "Test Category",
      sale_date: Date.current
    )
  end

  test "should be valid with valid attributes" do
    assert @sale.valid?
  end

  test "should require amount" do
    @sale.amount = nil
    assert_not @sale.valid?
    assert_includes @sale.errors[:amount], "can't be blank"
  end

  test "should require positive amount" do
    @sale.amount = -10
    assert_not @sale.valid?
    assert_includes @sale.errors[:amount], "must be greater than 0"
  end

  test "should require product_name" do
    @sale.product_name = nil
    assert_not @sale.valid?
    assert_includes @sale.errors[:product_name], "can't be blank"
  end

  test "should require category" do
    @sale.category = nil
    assert_not @sale.valid?
    assert_includes @sale.errors[:category], "can't be blank"
  end

  test "should require sale_date" do
    @sale.sale_date = nil
    assert_not @sale.valid?
    assert_includes @sale.errors[:sale_date], "can't be blank"
  end

  test "total_revenue should sum all sales amounts" do
    total = Sale.total_revenue
    assert_equal sales(:laptop).amount + sales(:shirt).amount + sales(:book).amount + sales(:lamp).amount, total
  end

  test "revenue_by_category should group sales by category" do
    revenue_by_category = Sale.revenue_by_category
    assert_equal sales(:laptop).amount, revenue_by_category["Electronics"]
    assert_equal sales(:shirt).amount, revenue_by_category["Clothing"]
    assert_equal sales(:book).amount, revenue_by_category["Books"]
    assert_equal sales(:lamp).amount, revenue_by_category["Home & Garden"]
  end

  test "sales_by_date should group sales by date" do
    sales_by_date = Sale.sales_by_date
    assert_includes sales_by_date.keys, sales(:laptop).sale_date
    assert_includes sales_by_date.keys, sales(:shirt).sale_date
  end

  test "categories should return distinct categories" do
    categories = Sale.categories
    assert_includes categories, "Electronics"
    assert_includes categories, "Clothing"
    assert_includes categories, "Books"
    assert_includes categories, "Home & Garden"
  end

  test "by_category scope should filter by category" do
    electronics_sales = Sale.by_category("Electronics")
    assert_includes electronics_sales, sales(:laptop)
    assert_not_includes electronics_sales, sales(:shirt)
  end

  test "recent scope should return sales from last 30 days" do
    # Create a sale from 35 days ago
    old_sale = Sale.create!(
      amount: 50.0,
      product_name: "Old Product",
      category: "Old Category",
      sale_date: 35.days.ago.to_date
    )

    recent_sales = Sale.recent
    assert_not_includes recent_sales, old_sale
    assert_includes recent_sales, sales(:laptop)
  end
end
