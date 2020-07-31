class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :stock
      t.integer :manufacturer_id, null: false, foreign_key: true
      t.float :price
      t.string :category

      t.timestamps
    end
  end
end
