class AddBioToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :bio, :string
  end
end
