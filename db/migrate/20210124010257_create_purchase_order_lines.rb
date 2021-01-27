class CreatePurchaseOrderLines < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_order_lines do |t|
      t.belongs_to :order, null: false, foreign_key: { to_table: :purchase_orders }
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :amount, default: 0.0

      t.timestamps
    end
  end
end
