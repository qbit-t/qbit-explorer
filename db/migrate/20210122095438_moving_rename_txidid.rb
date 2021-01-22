class MovingRenameTxidid < ActiveRecord::Migration
  def change
    rename_column :movings, :txidid, :txid
  end
end
