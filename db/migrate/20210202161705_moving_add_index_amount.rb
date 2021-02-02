class MovingAddIndexAmount < ActiveRecord::Migration
  def change
    add_index :movings, :amount
  end
end
