class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :description
      t.string :emission
      t.string :entity
      t.string :scale
      t.string :supply

      t.timestamps null: false
    end
  end
end
