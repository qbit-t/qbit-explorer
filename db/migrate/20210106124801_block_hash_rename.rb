class BlockHashRename < ActiveRecord::Migration
  def change
    rename_column :blocks, :hash, :blockid
  end
end
