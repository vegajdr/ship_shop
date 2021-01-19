# frozen_string_literal: true

class CreateStockQuantities < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_quantities do |t|
      t.belongs_to :location, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
