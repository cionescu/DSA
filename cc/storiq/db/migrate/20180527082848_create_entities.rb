class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :entities do |t|
      t.string :entity_type
      t.string :name

      t.timestamps
    end
  end
end
