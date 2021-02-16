class BlockAddBits < ActiveRecord::Migration
  def change
    add_column :blocks, :bits, :integer
  end
end
