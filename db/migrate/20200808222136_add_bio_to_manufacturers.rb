class AddBioToManufacturers < ActiveRecord::Migration[6.0]
  def change
    add_column :manufacturers, :bio, :string
  end
end
