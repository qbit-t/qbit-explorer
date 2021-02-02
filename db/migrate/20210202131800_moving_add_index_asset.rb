class MovingAddIndexAsset < ActiveRecord::Migration
  def change
    add_index :movings, :asset
  end
end
