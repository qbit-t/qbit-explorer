class MovingAddAsset < ActiveRecord::Migration
  def change
    add_column :movings, :asset, :string
  end
end
