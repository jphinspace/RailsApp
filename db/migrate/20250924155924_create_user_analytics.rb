class CreateUserAnalytics < ActiveRecord::Migration[8.0]
  def change
    create_table :user_analytics do |t|
      t.integer :user_id
      t.integer :page_views
      t.integer :session_duration
      t.date :date

      t.timestamps
    end
  end
end
