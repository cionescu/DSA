class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :entity, foreign_key: true
      t.integer :score
      t.string :title

      t.timestamps
    end
  end
end
