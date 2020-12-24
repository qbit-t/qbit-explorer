class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :block_id
      t.string :hash

      t.timestamps null: false
    end
  end
end
