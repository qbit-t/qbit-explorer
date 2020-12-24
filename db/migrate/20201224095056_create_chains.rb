class CreateChains < ActiveRecord::Migration
  def change
    create_table :chains do |t|
      t.string :name
      t.string :chain
      t.string :dapp

      t.timestamps null: false
    end
  end
end
