class CreateUsersProductsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :products do |t|
      t.index :user_id
      t.index :product_id
    end
  end
end
