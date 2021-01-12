class TransactionAddHeight < ActiveRecord::Migration
  def change
    add_column :transactions, :height, :integer
  end
end
