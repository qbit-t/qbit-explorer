class BlockAddTime < ActiveRecord::Migration
  def change
    add_column :blocks, :time, :integer
  end
end
