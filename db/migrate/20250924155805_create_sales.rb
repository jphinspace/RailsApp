class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.decimal :amount
      t.string :product_name
      t.string :category
      t.date :sale_date

      t.timestamps
    end
  end
end
