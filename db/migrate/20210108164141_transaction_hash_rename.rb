class TransactionHashRename < ActiveRecord::Migration
  def change
    rename_column :transactions, :hash, :txid
  end
end
