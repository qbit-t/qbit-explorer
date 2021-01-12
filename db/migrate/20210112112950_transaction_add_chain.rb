class TransactionAddChain < ActiveRecord::Migration
  def change
    add_column :transactions, :chain_id, :integer
  end
end
