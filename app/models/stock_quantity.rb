# frozen_string_literal: true

class StockQuantity < ApplicationRecord
  belongs_to :location
  belongs_to :product

  validates :quantity,
            numericality: {
              greater_than_or_equal_to: 0,
              message: proc do |stock_quantity|
                "Not enough #{stock_quantity.product.name} product, SKU: #{stock_quantity.product.sku} in stock'"
              end
            }
  validates :product_id, uniqueness: { scope: :location }

  def amount
    product.price * quantity
  end
end
