class BlockAddIndexBlockid < ActiveRecord::Migration
  def change
    add_index :blocks, :blockid
  end
end
