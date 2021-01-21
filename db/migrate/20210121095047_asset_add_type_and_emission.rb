class AssetAddTypeAndEmission < ActiveRecord::Migration
  def change
    add_column :assets, :typetx, :string
    add_column :assets, :emissiontx, :string
  end
end
