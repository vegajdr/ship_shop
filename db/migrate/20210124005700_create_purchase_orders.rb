class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders do |t|
      t.belongs_to :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
