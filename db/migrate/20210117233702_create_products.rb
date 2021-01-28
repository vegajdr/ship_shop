# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :sku
      t.decimal :price, default: 0.0

      t.index :name
      t.index :sku

      t.timestamps
    end
  end
end
