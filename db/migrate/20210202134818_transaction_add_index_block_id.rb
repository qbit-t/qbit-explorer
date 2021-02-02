class TransactionAddIndexBlockId < ActiveRecord::Migration
  def change
    add_index :transactions, :block_id
  end
end
