class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :target_id

      t.timestamps
    end

    add_index :followers, :target_id
  end
end
