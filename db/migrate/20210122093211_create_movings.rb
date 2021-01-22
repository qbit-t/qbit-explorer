class CreateMovings < ActiveRecord::Migration
  def change
    create_table :movings do |t|
      t.string :address
      t.string :transaction
      t.float :amount
      t.integer :time

      t.timestamps null: false
    end
  end
end
