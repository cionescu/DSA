class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :follower_id

      t.timestamps
    end

    add_index :followers, :follower_id
  end
end
