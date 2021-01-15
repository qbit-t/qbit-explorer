class TransactionAddTime < ActiveRecord::Migration
  def change
    add_column :transactions, :time, :integer
  end
end
