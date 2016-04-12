class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :sale_price
      t.integer :hit_count

      t.timestamps null: false
    end
  end
end
