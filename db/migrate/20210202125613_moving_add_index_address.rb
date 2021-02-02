class MovingAddIndexAddress < ActiveRecord::Migration
  def change
    add_index :movings, :address
  end
end
