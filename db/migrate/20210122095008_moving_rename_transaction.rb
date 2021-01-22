class MovingRenameTransaction < ActiveRecord::Migration
  def change
    rename_column :movings, :transaction, :txidid
  end
end
