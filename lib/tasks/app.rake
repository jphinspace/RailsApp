# Custom rake tasks for the RailsApp

namespace :test do
  desc "Run tests with coverage report"
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['test'].invoke
    puts "\nTest Coverage Report:"
    puts "Check coverage/index.html for detailed coverage report"
  end
end

namespace :db do
  desc "Reset database and reseed with sample data"
  task :reset_with_data => [:drop, :create, :migrate, :seed] do
    puts "Database reset and reseeded with sample data!"
  end
end

namespace :app do
  desc "Show application statistics"
  task :stats => :environment do
    puts "\n=== RailsApp Statistics ==="
    puts "Rails Version: #{Rails.version}"
    puts "Ruby Version: #{RUBY_VERSION}"
    puts "Environment: #{Rails.env}"
    puts "\n=== Database Statistics ==="
    puts "Total Sales: #{Sale.count}"
    puts "Total Revenue: $#{Sale.total_revenue.to_f.round(2)}"
    puts "User Analytics Records: #{UserAnalytic.count}"
    puts "Unique Users: #{UserAnalytic.unique_users}"
    puts "Average Session Duration: #{(UserAnalytic.average_session_duration.to_f / 60).round(1)} minutes"
    puts "\n=== Test Statistics ==="
    puts "Run 'rails test:coverage' for test coverage report"
  end
end