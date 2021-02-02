class TransactionAddIndexTxid < ActiveRecord::Migration
  def change
    add_index :transactions, :txid
  end
end
