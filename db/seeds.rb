# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
Sale.destroy_all
UserAnalytic.destroy_all

# Sample categories
categories = ['Electronics', 'Clothing', 'Books', 'Home & Garden', 'Sports', 'Toys']
products = {
  'Electronics' => ['iPhone 15', 'MacBook Pro', 'AirPods', 'iPad', 'Apple Watch'],
  'Clothing' => ['T-Shirt', 'Jeans', 'Sneakers', 'Jacket', 'Dress'],
  'Books' => ['Fiction Novel', 'Programming Guide', 'Cookbook', 'Biography', 'Science Book'],
  'Home & Garden' => ['Coffee Maker', 'Plant Pot', 'Lamp', 'Cushion', 'Garden Tool'],
  'Sports' => ['Tennis Racket', 'Basketball', 'Running Shoes', 'Yoga Mat', 'Dumbbells'],
  'Toys' => ['LEGO Set', 'Board Game', 'Action Figure', 'Puzzle', 'Remote Car']
}

puts "Creating sales data..."

# Generate sales data for the last 90 days
90.times do |i|
  date = i.days.ago.to_date
  
  # Generate 5-15 sales per day
  rand(5..15).times do
    category = categories.sample
    product = products[category].sample
    amount = case category
             when 'Electronics'
               rand(200.0..2000.0)
             when 'Clothing'
               rand(20.0..200.0)
             when 'Books'
               rand(10.0..50.0)
             when 'Home & Garden'
               rand(15.0..300.0)
             when 'Sports'
               rand(25.0..500.0)
             when 'Toys'
               rand(10.0..150.0)
             end

    Sale.create!(
      amount: amount.round(2),
      product_name: product,
      category: category,
      sale_date: date
    )
  end
end

puts "Created #{Sale.count} sales records"

# Generate user analytics for the last 90 days
puts "Creating user analytics data..."

90.times do |i|
  date = i.days.ago.to_date
  
  # Generate analytics for 20-50 users per day
  rand(20..50).times do
    user_id = rand(1..1000)  # Simulate 1000 possible users
    page_views = rand(1..50)
    session_duration = rand(30..3600)  # 30 seconds to 1 hour in seconds

    UserAnalytic.create!(
      user_id: user_id,
      page_views: page_views,
      session_duration: session_duration,
      date: date
    )
  end
end

puts "Created #{UserAnalytic.count} user analytics records"
puts "Sample data creation complete!"

# Display some summary statistics
puts "\n=== SUMMARY ==="
puts "Total Revenue: $#{Sale.total_revenue.to_f.round(2)}"
puts "Revenue by Category:"
Sale.revenue_by_category.each { |cat, rev| puts "  #{cat}: $#{rev.to_f.round(2)}" }
puts "\nUser Analytics:"
puts "  Total Page Views: #{UserAnalytic.total_page_views}"
puts "  Unique Users: #{UserAnalytic.unique_users}"
puts "  Average Session Duration: #{UserAnalytic.average_session_duration.to_f.round(2)} seconds"
