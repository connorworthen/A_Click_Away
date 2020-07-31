class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
  end
end
