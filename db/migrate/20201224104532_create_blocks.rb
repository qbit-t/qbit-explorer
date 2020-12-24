class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :chain_id
      t.string :hash
      t.integer :height

      t.timestamps null: false
    end
  end
end
