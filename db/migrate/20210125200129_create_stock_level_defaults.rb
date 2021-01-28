class CreateStockLevelDefaults < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_level_defaults do |t|
      t.belongs_to :location, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
